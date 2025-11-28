
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.model.Option"%>

<%@page import="java.util.Optional"%>

<%@page import="com.zzorg.config.Database"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.zzorg.model.User"%>
<%@ page import="com.zzorg.repository.*"%>

<%@ page import="com.zzorg.model.Survey"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>



<%
// carrega latest surveys do sistem
User user = (User) session.getAttribute("LoggedUser");

SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();
List<Survey> latest = surveyRepository.findAll(0, 7);
request.setAttribute("latestSurveys", latest);

// carrega latest surveys do user

List<Survey> latestUserSurveys = surveyRepository.findByUser(user.getId(), 0, 5);
request.setAttribute("latestUserSurveys", latestUserSurveys);


%>

<jsp:include page="/WEB-INF/jsp/includes/header.jsp"></jsp:include>

<h2 class="font-bold text-4xl">
	Bem vindo,
	<span class="text-primary"> ${userLogged.name}</span></h2>


<div class="pt-5">
	<div class="flex items-center gap-3">
		<h2 class="text-2xl font-semibold">Suas últimas enquetes criadas:</h2>
		<a href="${pageContext.request.contextPath}/survey/create.jsp">
			<button class="btn-primary bg-secondary cursor-pointer">Criar
				nova enquete</button>
		</a>
	</div>
	
	<div id="MyLatestSurveys">
	
	</div>

</div>

<div class="pt-5">
	<h2 class="text-2xl font-semibold">Ultimas enquetes criadas:</h2>
	
	<div id="latestSurveys">
	</div>
	
</div>
<script defer type="module">

import SurveyList from "./static/js/components/SurveysList.js"

new SurveyList("MyLatestSurveys", "http://localhost:8080/vote-now/api/surveys/user/${userLogged.id}?page=1&limit=3")

</script>
<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>
