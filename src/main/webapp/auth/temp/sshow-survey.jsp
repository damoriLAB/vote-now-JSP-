
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
if (id == -1) throw new NotFoundResource("user id blank");



User user = (User) session.getAttribute("LoggedUser");


SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();

Optional<Survey> surveyOpt = surveyRepository.findById(id);

//Id invalido
if (surveyOpt.isEmpty()) {
	response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Param: "+id);
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
		
		Option optionSelected = avaliableOptions.stream()
				.filter(o -> o.getId() == form.getSelectedOption())
				.findFirst()
				.orElse(null);
		
		if (optionSelected == null) form.getErrors().add("Invalid option");

		if(form.validate()){
			//mudar voto
			if(findUserVote.isPresent()){
				Vote userVote = findUserVote.get();
				userVote.getOption().setId(form.getSelectedOption());
				voteRepository.update(userVote);
				request.setAttribute("sucess", "Vote was updated!");
				request.setAttribute("userVote", userVote);
			}
			else {
				
				Vote newVote = Vote.builder()
						.option(optionSelected)
						.survey_id(survey.getId())
						.user(user)
						.build();
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

<p class="text-right">
	Enquente criada por <a
		href="${pageContext.request.contextPath}/users/show.jsp?id=${survey.user.id}"
		class="pointer border-b-2">${survey.user.name}</a>
</p>

<h1 class="text-center text-5xl my-3">Survey View</h1>
<h2 class="text-center text-2xl mt-5">${survey.title}</h2>
<h3 class="text-center text-1xl my-1">${survey.description}</h3>

<form id="enviarVoto"
	action="${pageContext.request.contextPath}/survey/show.jsp?id=${survey.id}"
	method="POST">

	<p class="text-3xl font-thin mb-1">Opções:</p>

	<c:forEach var="opt" items="${survey.options}">
		<div>
			<input type="checkbox" name="selectedOption" value="${opt.id}"
				<c:if test="${opt.id == userVote.option.id}">checked</c:if>>
			<span class="font-bold text-xl">${opt.title}</span>
		</div>
	</c:forEach>

	<button type="submit" class="btn-primary bg-secondary w-full mt-5">Votar</button>

	<c:if test="${not empty errors}">
		<c:forEach var="msg" items="${errors}">
			<p class="msg-error">${msg}</p>
		</c:forEach>
	</c:if>

	<c:if test="${ not empty sucess  }">
		<p class="msg-sucess">${sucess}!</p>
	</c:if>
</form>

<h1 class="text-center text-5xl my-3 mt-5">Stats</h1>


<div>
	<canvas id="myChart"></canvas>
</div>

<h1 class="text-center text-5xl my-3 mt-5">Latest votes</h1>
<div id="surveyLatestVotes">

</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">

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
	
	
	
	const ctx = document.getElementById('myChart');

	new Chart(ctx, {
		type : 'bar',
		data : {
			labels : labels,
			datasets : [ {
				label : '# of Votes',
				data : votes,
				borderWidth : 1
			} ]
		},
		options : {
			scales : {
				y : {
					beginAtZero : true
				}
			}
		}
	});
</script>

<script type="module">


import VotesList from "../static/js/components/VotesList.js"

new VotesList("#surveyLatestVotes", "votes/survey",${survey.id}, 5)

</script>
<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>

