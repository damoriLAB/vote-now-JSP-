<%@page import="com.zzorg.exception.NotFoundResource"%>
<%@page import="com.zzorg.web.dto.EditUserForm"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.UserRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.zzorg.web.util.RequestUtils"%>
<%@page import="com.zzorg.model.User"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.config.Database"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%

int id = RequestUtils.requireIntParam(request, response, "id");
if (id == -1) throw new NotFoundResource("user not provided");


UserRepository userRepository = AppContext.daoFactory().userRepository();

Optional<User> profile_user = userRepository.findById(id);
User user = (User) session.getAttribute("LoggedUser");

if(profile_user.isEmpty()) throw new NotFoundResource("user not found");

// Apenas permitir editar proprio perfil // ou no futuro algum ROLE
if (!profile_user.get().getId().equals(user.getId())) {
	response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bad Request");
}

// TODO: acredito que fazendo assim tem delay, como o processamente ta depois , a HTML vai renderizar com info antiga
request.setAttribute("profile", profile_user.get());
%>

<%
// TODO : validador de email

if (request.getMethod().equals("POST")) {

	EditUserForm form = new EditUserForm(request);


	if (form.validate()) {

		User u = profile_user.get();
		
		u.setEmail(form.getEmail());
		u.setName(form.getName());
		u.setIconURL(form.getIconURL());
		u.setUsername(form.getUsername());

		int rows = userRepository.update(u);

		if (rows > 0){
			request.setAttribute("sucess", "Profile updated!");
			if(u.getId() == user.getId()) session.setAttribute("LoggedUser", u);
		}
		else
			form.getErrors().add("Seu perfil não foi atualizado, tente mais tarde!");
	}

	request.setAttribute("errors", form.getErrors());
}
%>

<jsp:include page="/WEB-INF/jsp/includes/header.jsp"></jsp:include>


<h1 class="text-center text-4xl mt-5">Editar Perfil</h1>

<div class="flex justify-center mt-5">
	<form
		action="${pageContext.request.contextPath}/users/edit.jsp?id=${userLogged.id}"
		method="post" class="w-3/4">

		<div class="mt-5">
			<label for="iconUrl">Icon(URL)</label> <input type="text"
				id="iconUrl" name="iconURL" class="input"
				value="${profile.iconURL}">
		</div>


		<div>
			<label for="name">Name</label> <input type="text" id="name"
				name="name" class="input" value="${profile.name }">
		</div>

		<div>
			<label for="username">Username</label> <input type="text"
				id="username" name="username" class="input"
				value="${profile.username }">
		</div>

		<div>
			<label for="email">Email</label> <input type="email" id="email"
				name="email" class="input" value="${profile.email }">
		</div>




		<button type="submit" class="btn-primary bg-primary w-full mt-2">Enviar</button>

		<button type="submit" class=" w-full mt-2">
			<a>Mudar senha</a>
		</button>




		<c:forEach var="msg" items="${sucess}">
			<p class="msg-sucess">${msg}</p>
		</c:forEach>

		<c:forEach var="msg" items="${errors}">
			<p class="msg-error">${msg}</p>
		</c:forEach>


	</form>
</div>


<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>