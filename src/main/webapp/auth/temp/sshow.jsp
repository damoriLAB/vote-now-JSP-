<%@page import="com.zzorg.repository.SurveyRepository"%>
<%@page import="com.zzorg.exception.NotFoundResource"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.UserRepository"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.config.Database"%>

<%@page import="java.net.http.HttpResponse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>

<%@ page import="com.zzorg.web.util.RequestUtils"%>



<%@ page import="com.zzorg.model.User"%>
<%@ page import="com.zzorg.model.Survey"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%
// validate params // validate params TODO : logica errada, tem ser sendError() nao return
int id = RequestUtils.requireIntParam(request, response, "id");
if (id == -1) throw new NotFoundResource("user id blank");

UserRepository userRepository = AppContext.daoFactory().userRepository();

Optional<User> profile_user = userRepository.findById(id);

if (profile_user.isEmpty()) {
	response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
}

SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();

List<Survey> surveysUser = surveyRepository.findByUser(id, 0, 7);


request.setAttribute("userProfile", profile_user.get());
request.setAttribute("userSurveys", surveysUser);
%>


<jsp:include page="/WEB-INF/jsp/includes/header.jsp"></jsp:include>

<div class="w-full flex flex-col items-center">
	<div
		
		class="rounded-full cursor-pointer border-2 border-gray-600 group-hover:border-primary transition"
		style="background-image: url('${userProfile.iconURL}'); 
					width: 180px; 
					height: 180px;
					background-position: center center;
					background-repeat:  no-repeat;
					"
		>
	</div>

	<h1 class="mt-3 text-4xl">${userProfile.name}</h1>
	<p class="text-gray-500 ">${userProfile.email }</p>
	
	<c:if test="${userLogged != null and userProfile != null and userLogged.id == userProfile.id}">
		<a href="${pageContext.request.contextPath}/users/edit.jsp?id=${userLogged.id}">
			<button class="mt-4 btn-primary bg-slate-900 cursor-pointer"> Editar Perfil</button>
		</a>
	</c:if>
	

</div>




<h2 class="text-2xl font-semibold">Enquetes criada por ${userProfile.name}:</h2>
<div id="userLatestSurveys"></div>

<h2 class="text-2xl font-semibold">Últimos votos de ${userProfile.name}:</h2>
<div id="userLatesVotes"></div>

<script type="module" >

import SurveyList from "../static/js/components/SurveysList.js"
import VotesList from "../static/js/components/VotesList.js"

new SurveyList("userLatestSurveys", "http://localhost:8080/vote-now/api/surveys/user/${userProfile.id}?page=1&limit=5")
new VotesList("#userLatesVotes", "votes/user",${userProfile.id}, 5)

</script>

<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>
