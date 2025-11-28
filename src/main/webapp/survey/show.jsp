
<%@page import="com.zzorg.repository.VoteCountRepository"%>
<%@page import="com.zzorg.web.dto.VoteForm"%>
<%@page import="com.zzorg.exception.NotFoundResource"%>
<%@page import="com.zzorg.repository.VoteRepository"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.SurveyRepository"%>
<%@page import="com.zzorg.repository.sqlObject.VoteSqlObject"%>
<%@page import="com.zzorg.model.VoteCount"%>
<%@page import="com.zzorg.repository.sqlObject.OptionSqlObject"%>
<%@page import="com.zzorg.web.util.RequestUtils"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.repository.sqlObject.UserSqlObject"%>
<%@page import="com.zzorg.repository.sqlObject.SurveySqlObject"%>
<%@page import="com.zzorg.config.Database"%>
<%@page import="org.jdbi.v3.core.Jdbi"%>
<%@page import="com.zzorg.model.Option"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="com.zzorg.model.Vote"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ page import="com.zzorg.model.User"%>

<%@ page import="com.zzorg.model.Survey"%>


<%
int id = RequestUtils.requireIntParam(request, response, "id");
if (id == -1)
	throw new NotFoundResource("user id blank");

User user = (User) session.getAttribute("LoggedUser");

SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();

Optional<Survey> surveyOpt = surveyRepository.findById(id);

//Id invalido
if (surveyOpt.isEmpty()) {
	response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Param: " + id);
	return;
}

Survey survey = surveyOpt.get();

request.setAttribute("survey", survey);

VoteRepository voteRepository = AppContext.daoFactory().voteRepository();

// pegar voto cadastrado anteriomente 
Optional<Vote> findUserVote = voteRepository.findByUserAndSurvey(user.getId(), survey.getId());

if (findUserVote.isPresent())
	request.setAttribute("userVote", findUserVote.get());
%>


<%
// processa o voto

if (request.getMethod().equals("POST")) {

	VoteForm form = new VoteForm(request);

	if (form.validate()) {
		//pega erros iniciais

		List<Option> avaliableOptions = survey.getOptions();

		Option optionSelected = avaliableOptions.stream().filter(o -> o.getId() == form.getSelectedOption()).findFirst()
		.orElse(null);

		if (optionSelected == null)
	form.getErrors().add("Invalid option");

		if (form.validate()) {
	//mudar voto
	if (findUserVote.isPresent()) {
		Vote userVote = findUserVote.get();
		userVote.getOption().setId(form.getSelectedOption());
		voteRepository.update(userVote);
		request.setAttribute("sucess", "Vote was updated!");
		request.setAttribute("userVote", userVote);
	} else {

		Vote newVote = Vote.builder().option(optionSelected).survey_id(survey.getId()).user(user).build();
		voteRepository.insert(newVote);
		request.setAttribute("sucess", "something with sucess!!!");
		request.setAttribute("userVote", newVote);
	}
		}
	}

	session.setAttribute("errors", form.getErrors());

}
%>

<%
//contagem de votos para o grafico
VoteCountRepository voteCountRepository = AppContext.daoFactory().voteCountRepository();

List<VoteCount> votesCount = voteCountRepository.findBySurveyId(survey.getId());

request.setAttribute("votesCount", votesCount);
%>




<jsp:include page="/WEB-INF/jsp/includes/header.jsp"></jsp:include>

<!-- WRAPPER -->
<div class="flex flex-col bg-white text-gray-900 mt-16 min-h-screen">

	<!-- TOP GRADIENT (suave, vibrante, premium) -->
	<div
		class="absolute inset-x-0 top-0 h-72 bg-gradient-to-tr from-purple-500/25 via-pink-400/25 to-blue-400/25 blur-3xl opacity-40 pointer-events-none">
	</div>

	<!-- HERO -->
	<section class="py-16 px-6 relative">
		<div class="max-w-4xl mx-auto text-center animate-fade-in">
			<span
				class="inline-block px-4 py-1 rounded-full bg-purple-600/10 text-purple-700 font-medium text-sm">
				${survey.status} </span>

			<h1 class="mt-6 text-4xl font-bold tracking-tight text-gray-900">
				${survey.title}</h1>

			<p class="mt-3 text-gray-600">
				Criada por <span class="font-semibold text-gray-800">${survey.user.name}</span>
				• ${survey.createdAt}
			</p>
		</div>
	</section>

	<!-- MAIN CONTENT -->
	<div
		class="flex-1 lg:px-20 content-start w-full justify-top px-6 pb-16 grid md:grid-cols-5 gap-10 relative">

		<!-- COLUNA ESQUERDA (survey + votação) -->
		<div class="md:col-span-3 space-y-10">

			<!-- CARD DA SURVEY -->
			<div
				class="p-10 rounded-3xl shadow-md border border-gray-200 relative overflow-hidden animate-slide-up bg-white">

				<!-- Borda luminosa -->
				<div
					class="absolute inset-0 rounded-3xl border-2 border-transparent bg-gradient-to-br from-purple-500/30 via-pink-500/30 to-blue-500/30 opacity-40 -z-10"></div>

				<h2
					class="text-2xl font-semibold text-gray-900 flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg"
						class="w-6 h-6 text-purple-600" fill="none" viewBox="0 0 24 24"
						stroke="currentColor">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3" />
                    </svg>
					Sobre esta survey
				</h2>

				<p class="mt-4 text-gray-600 leading-relaxed">${survey.description}</p>

				<!-- Formulário -->
				<form 
				method="POST" 
				action="${pageContext.request.contextPath}/survey/show.jsp?id=${survey.id}" 
				class="mt-10 space-y-6">

					<div class="space-y-4">

						<!-- OPTION ITEM -->

						<c:forEach var="opt" items="${survey.options}">
						
							<label class="block group cursor-pointer">
								<div class="flex items-center gap-4 p-4 border border-gray-200 rounded-xl transition-all
                                        group-hover:border-primary/40 group-hover:bg-primary/5">
									<input type="checkbox" name="selectedOption" value="${opt.id}"
									<c:if test="${opt.id == userVote.option.id}">checked</c:if>
									class="w-5 h-5 text-purple-600 rounded focus:ring-primary">

								<span class="font-medium text-gray-900 flex items-center gap-2">
									${opt.title} </span>
								</div>
							</label>
						</c:forEach>
					
					</div>

					<button
						class="mt-6 px-8 py-3 w-full font-semibold text-white rounded-xl shadow-lg bg-gradient-to-r 
                               from-primary via-primary/80 to-blue-600
                               hover:scale-105 active:scale-95 transition-all">
						Enviar voto</button>

					<c:if test="${not empty errors}">
						<c:forEach var="msg" items="${errors}">
							<p class="msg-error">${msg}</p>
						</c:forEach>
					</c:if>

					<c:if test="${ not empty sucess  }">
						<p class="msg-sucess">${sucess}!</p>
					</c:if>
				</form>
			</div>
		</div>
	
		
			<!-- COLUNA DIREITA — Últimos votos -->
			<div class=" md:col-span-2 space-y-5 relative">
			
				<div class="">
								<h3
					class="text-xl font-semibold text-gray-900 flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg"
						class="w-5 h-5 text-blue-600" fill="none" viewBox="0 0 24 24"
						stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round"
							stroke-width="2" d="M14 10l-2 2m0 0l-2-2m2 2V6m0 6l2 2m-2-2l-2 2" />
                </svg>
					Últimos votos
				</h3>

				<div id="surveyLatestVotes"  class="space-y-5 mt-2">

				</div>
			</div>
		
				
				</div>
				
				<div class="max-w-full px-4 sm:px-6 lg:px-8 mt-10 md:col-span-5">
  <div class="bg-white shadow-lg rounded-2xl p-6 border border-gray-200 w-full">
    <h2 class="text-2xl font-semibold text-gray-800 mb-4">
      Resultado Parcial
    </h2>
    <div class="h-72 w-full">
      <canvas id="surveyChart"></canvas>
    </div>
  </div>
</div>


	</div>
	
	

</div>
<script type="module">


import VotesList from "../static/js/components/VotesList.js"

new VotesList("#surveyLatestVotes", "votes/survey",${survey.id}, 3)

</script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<script>
		// Exemplo: substitua pelos dados vindos do backend
	const labels = [
	    <c:forEach var="n" items="${votesCount}" varStatus="s">
	      "${n.option.title}"<c:if test="${!s.last}">,</c:if>
	    </c:forEach>
	  ];
	
	const votes = [
	    <c:forEach var="n" items="${votesCount}" varStatus="s">
	      ${n.count}<c:if test="${!s.last}">,</c:if>
	    </c:forEach>
	  ];

		const ctx = document.getElementById("surveyChart");

		new Chart(ctx, {
			type : "bar",
			data : {
				labels : labels,
				datasets : [ {
					label : "Votos",
					data : votes,
					backgroundColor : [ 
					"#6366f1", // indigo
					"#10b981", // green
					"#f59e0b" // amber
					],
					borderColor : "#1f2937",
					borderWidth : 1,
					borderRadius : 10,
					barPercentage : 0.7,
					categoryPercentage : 0.6
				} ]
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				animation : {
					duration : 900,
					easing : "easeOutElastic"
				},
				scales : {
					y : {
						beginAtZero : true,
						ticks : {
							color : "#1f2937"
						},
						grid : {
							color : "#e5e7eb"
						}
					},
					x : {
						ticks : {
							color : "#1f2937"
						},
						grid : {
							display : false
						}
					}
				},
				plugins : {
					legend : {
						labels : {
							color : "#1f2937",
							font : {
								size : 14,
								weight : 600
							}
						}
					},
					tooltip : {
						backgroundColor : "#1f2937",
						titleColor : "#fff",
						bodyColor : "#fff",
						borderWidth : 0,
						padding : 10,
						bodyFont : {
							size : 14
						}
					}
				}
			}
		});
	</script>

<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>
