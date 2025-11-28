<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.UserRepository"%>
<%@page import="com.zzorg.web.dto.LoginForm"%>
<%@page import="com.zzorg.config.DaoFactory"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.config.Database"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.zzorg.model.User"%>




<%
// validar login
if (request.getMethod().equals("POST")) {

	LoginForm form = new LoginForm(request);

	if (form.validate()) {

		UserRepository userRepository = AppContext.daoFactory().userRepository();
		Optional<User> userOpt = userRepository.findByEmailAndPassword(form.getEmail(), form.getPassword());

		if (userOpt.isPresent()) {

			session.setAttribute("LoggedUser", userOpt.get());
			response.sendRedirect(request.getContextPath() + "/home.jsp");
			return;

		}
		
		form.getErrors().add("Usuario ou senha invalidos");

	}

	request.setAttribute("errors", form.getErrors());
	request.setAttribute("email", form.getEmail());
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">



<script type="module"
	src="${pageContext.request.contextPath}/static/js/main.js">
	
</script>

<title>Login view</title>

</head>
<body class="bg-backgroud-main">



	<div class="w-full flex justify-center items-center flex-col mt-20">
		<div
			class="flex justify-center items-center flex-col bg-white px-2 py-15 rounded-md">
			<form action="${pageContext.request.contextPath}/auth/login.jsp"
				method="post" class="flex flex-col items-center w-3/4">
				<h1 class="text-6xl mb-10">Login</h1>
				<div>
					<label for="email">Email</label> <input type="email" id="email"
						name="email" class="input" value="${email}">
				</div>
				<div>
					<label for="password">Senha</label> <input type="password"
						id="password" name="password" class="input">
				</div>

				<div class="flex flex-col w-full">
					<button type="submit" class="btn-primary bg-secondary mt-5 w-full ">Entrar</button>
					<button type="submit" class="text-black mt-3">
						<a href="${pageContext.request.contextPath}/auth/register.jsp">
							Criar conta </a>
					</button>

				</div>

				<c:forEach var="msg" items="${errors}">
					<p class="msg-error w-full">${msg}</p>

				</c:forEach>
			</form>
		</div>
	</div>

	<script>
		
	</script>
</body>
</html>

