<%@page import="com.zzorg.repository.OptionRepository"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.SurveyRepository"%>
<%@page import="com.zzorg.web.dto.NewSurveyForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ page import="com.zzorg.model.User"%>
<%@ page import="com.zzorg.model.Option"%>
<%@ page import="com.zzorg.model.Survey"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashSet"%>


<%

User user = (User) session.getAttribute("LoggedUser");

if (request.getMethod().equals("POST")) {

	NewSurveyForm form = new NewSurveyForm(request);

	if (form.validate()) {
		OptionRepository optionRepository = AppContext.daoFactory().optionRepository();
		SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();
		Survey survey = Survey.builder()
				.title(form.getTitle())
				.description(form.getDescription())
				.user(user)
				.build();
		int surveyID = surveyRepository.insert(survey);
		
		survey.setId(surveyID);
		
		
		List<Option> surveyOptions = form.getOptions().stream().map(title -> {
			Option o =  Option.builder()
					.title(title)
					.survey(survey)
					.build();
			
			int oId = optionRepository.insert(o);
			o.setId(oId);
			
			return o;
		}).toList();



		survey.setOptions(surveyOptions);
		response.sendRedirect(request.getContextPath() + "/survey/show.jsp?id=" + survey.getId());
		return;

	}
	
	request.setAttribute("errors", form.getErrors());
	request.setAttribute("form", form);
}
%>


<jsp:include page="/WEB-INF/jsp/includes/header.jsp"></jsp:include>




<div>
	<div class="flex justify-center">
		<form id="NewSurveyForm"
			action="${pageContext.request.contextPath}/survey/create.jsp"
			method="POST"
			class="w-3/4">
			<h1 class="text-5xl text-center py-4">Create new Survey</h1>
			<div>
				<label for="title">Title</label> <input type="text" class="input" id="title"
					name="title" value="${form.title}" required >
			</div>
			<div>
				<label for="description">Description</label> <input class="input" type="text"
					id="description" name="description" value="${form.description}">
			</div>
			<div id="OptionsContainer">
				<label for="Options">Opções:</label></br> <input type="text"
					class="input" name="options" placeholder="Digite uma opção"></br>
				<input type="text" class="input" name="options"
					placeholder="Digite uma opção"></br>

			</div>
			<button id="addOpt" class="btn-primary bg-primary mt-3 w-full" type="button" onclick="addOption()">Adicionar
				+1 Opção</button>
			<button type="submit" class="btn-primary bg-secondary mt-3 w-full">Registrar enquete</button>

			<c:if test="${not empty errors}">
				<c:forEach var="err" items="${errors}">
					<p class="msg-error"> - ${err}</p>
				</c:forEach>
			</c:if>
		
		</form>
	</div>
</div>

<script>
	// cria nova opção
	function addOption() {
		const containerOpt = document.querySelector("#OptionsContainer");
		const input = document.createElement("input");
		input.type = "text";
		input.name = "options";
		input.placeholder = "Digite uma opção";
		input.className = "input";
		containerOpt.appendChild(input);
		containerOpt.appendChild(document.createElement("br"));

	}
</script>
<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>
