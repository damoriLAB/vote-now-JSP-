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
<div class="min-h-screen bg-white text-gray-900 px-4 sm:px-6 lg:px-8 pt-28 pb-20">

  <!-- HEADER DO USUÁRIO -->
  <section 
    class="relative overflow-hidden rounded-md bg-gradient-to-br from-primary via-blue-300 to-primary p-[2px] shadow-xl animate-fade-in">
    
    <div class="bg-white rounded-md p-8 sm:p-10 flex flex-col sm:flex-row items-center gap-6">
      
      <!-- Avatar -->
      <img 
        src="${userProfile.iconURL}"
        class="w-28 h-28 rounded-full shadow-lg ring-4 ring-white object-cover animate-float-slow"
      />

      <!-- User info -->
      <div class="flex-1">
        <h1 class="text-3xl font-bold tracking-tight mb-1">${userProfile.name}</h1>
        <p class="text-gray-500">Membro desde ${userProfile.createdAt}</p>
      </div>

      <!-- Botão Editar -->

      <c:if test="${userLogged != null and userProfile != null and userLogged.id == userProfile.id}">
		<a href="${pageContext.request.contextPath}/users/edit.jsp?id=${userLogged.id}">
			<button class="px-5 py-2.5 rounded-xl bg-primary text-white font-semibold shadow hover:bg-violet-700 active:scale-95 transition-all"> 
			Editar Perfil</button>
		</a>
	</c:if>
    </div>
  </section>


  <!-- ÚLTIMAS SURVEYS CRIADAS PELO USUÁRIO -->
  <section class="mt-12">
    <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
      <span class="w-2 h-2 bg-fuchsia-600 rounded-full"></span>
      Últimas Surveys Criadas
    </h2>

<!-- class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6" -->
    <div id="userLatestSurveys" >

     
    </div>
  </section>

  <!-- ÚLTIMOS VOTOS DO USUÁRIO -->
  <section class="mt-12">
    <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
      <span class="w-2 h-2 bg-orange-600 rounded-full"></span>
      Últimos Votos
    </h2>

    <div id="userLatesVotes"></div>
  </section>
</div>

<!-- Animations -->
<style>
  .animate-float-slow { animation: float 3s ease-in-out infinite; }
  .animate-fade-in { animation: fade-in 0.6s ease both; }
  .animate-card-fade { animation: fade-up 0.6s ease both; }
  .animate-slide-up { animation: slide-up 0.6s ease both; }

  @keyframes float {
    0% { transform: translateY(0); }
    50% { transform: translateY(-6px); }
    100% { transform: translateY(0); }
  }
  @keyframes fade-in { from { opacity: 0; } to { opacity: 1; } }
  @keyframes fade-up {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }
  @keyframes slide-up {
    from { opacity: 0; transform: translateY(15px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>


<script type="module">

import SurveyList from "../static/js/components/SurveysList.js"
import VotesList from "../static/js/components/VotesList.js"

new SurveyList("userLatestSurveys", "http://localhost:8080/vote-now/api/surveys/user/${userProfile.id}?page=1&limit=5")
new VotesList("#userLatesVotes", "votes/user",${userProfile.id}, 5)

</script>

<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>


