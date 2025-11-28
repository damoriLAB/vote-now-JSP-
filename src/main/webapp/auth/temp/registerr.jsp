<%@page import="com.zzorg.web.dto.RegisterForm"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.UserRepository"%>
<%@page import="com.zzorg.config.Database"%>
<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.zzorg.model.User"%>




<%
// create new user
if (request.getMethod().equals("POST")) {


	RegisterForm form = new RegisterForm(request);

	request.setAttribute("form", form);

	if(form.validate()){
		UserRepository userRepository = AppContext.daoFactory().userRepository();
		
		Optional<User> sameEmailUser = userRepository.findByEmail(form.getEmail());
		Optional<User> sameUsername = userRepository.findByUsername(form.getUsername());
		
		sameEmailUser.ifPresent( u -> form.getErrors().add("Email already exists"));
		sameUsername.ifPresent(u -> form.getErrors().add("Username already exists"));
		
		if(form.validate()){
			
			User user = User.builder()
					.name(form.getName())
					.username(form.getUsername())
					.email(form.getEmail())
					.password(form.getPassword())
					.build();
			
			int id = userRepository.insert(user);
			user.setId(id);
			
			session.setAttribute("LoggedUser", user);
			response.sendRedirect(request.getContextPath() + "/home.jsp");
			return;
		}
		
		
	}
	
	request.setAttribute("errors", form.getErrors());
	request.setAttribute("form", form);


}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Register view</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
	

<script type="module" src="${pageContext.request.contextPath}/static/js/main.js"> </script>

</head>
<body class="bg-backgroud-main">

	<div class="w-full flex justify-center items-center flex-col mt-20">


		<div
			class="flex justify-center items-center flex-col bg-white px-2 py-15 rounded-md">
			<h1 class="text-6xl mb-10">Register</h1>

			<form id=""
				action="${pageContext.request.contextPath}/auth/register.jsp"
				method="POST" class="w-3/4">

				<div>
					<label for="name">Name:</label> <input type="text" id="name"
						name="name" class="input" value=<c:out value="${form.name}"></c:out>>
				</div>

				<div>
					<label for="username">Username:</label> <input type="text"
						id="username" name="username" class="input"
						value=<c:out value="${form.username}"></c:out>>
				</div>

				<div>
					<label for="email">Email:</label> <input type="email" id="email"
						name="email" class="input" value=<c:out value="${form.email}"></c:out>>
				</div>
				<div>
					<label for="password">Password:</label> <input type="password"
						id="password" name="password" class="input"
						value=<c:out value="${form.password}"></c:out>>
				</div>
				<button type="submit" class="btn-primary bg-secondary mt-5 w-full">Register</button>

				<button type="button" class="btn-secondary mt-5 w-full">
					<a href="${pageContext.request.contextPath}/auth/login.jsp">Já
						tenho conta</a>
				</button>



				<c:forEach var="msg" items="${errors}">
					<p class="msg-error">${msg}</p>

				</c:forEach>
			</form>

		</div>
	</div>

</body>
</html>