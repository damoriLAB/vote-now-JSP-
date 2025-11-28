<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.zzorg.model.User"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>User profile</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
	
	<script type="module"  src="${pageContext.request.contextPath}/static/js/main.js"> </script> 

</head>
<body class="flex flex-col min-h-screen ">
	<header class="pt-8 menu">
		<h1 class="text-center text-5xl font-black text-primary">Vote Now</h1>
		
		<nav class="flex justify-between items-center p-5 text-secondary md:text-xl">
			<div>
				<a href="${pageContext.request.contextPath}/home.jsp" class="border-b-1">Início</a> | <a
					href="${pageContext.request.contextPath}/home.jsp" class="border-b-1">Enquetes</a> | <a
					href="${pageContext.request.contextPath}/users/show.jsp?id=${userLogged.id}" class="border-b-1">Perfil</a>
			</div>


			<!-- user menu -->
			<div class="relative group">
				<div 
					class="rounded-full 
					cursor-pointer 
					border-2 border-gray-600 
					group-hover:border-primary 
					transition"
					style="background-image: url('${userLogged.iconURL}'); 
					width: 50px; 
					height: 50px;
					background-repeat: round;
					background-position: center center;
					"
					
				>
					</div>
				<div
					class="
				      absolute 
				      
				      hidden 
				      right-0
				      mt-0 
				      w-40 
				      bg-white 
				      text-gray-700 
				      rounded-md 
				      shadow-lg 
				      opacity-0 
				      scale-95 
				      group-hover:opacity-100 
				      group-hover:block 
				      hover:block
				      group-hover:scale-100 
				      transform transition-all 
				      duration-200 
				      origin-top-right">
				      <!-- Items drop menu avatar -->
						<a href="${pageContext.request.contextPath}/users/show.jsp?id=${userLogged.id}"
							class="block px-4 py-2 hover:bg-gray-100 rounded-t-xl">
							Perfil
						</a> 
						
						<a href="${pageContext.request.contextPath}/users/edit.jsp?id=${userLogged.id}"
							class="block px-4 py-2 hover:bg-gray-100 rounded-b-xl">
							Editar perfil
						</a>	
											
						<a href="${pageContext.request.contextPath}/users/logout.jsp"
							class="block px-4 py-2 hover:bg-gray-100 rounded-b-xl">
							Logout
						</a>
						

				</div>
			</div>

		</nav>
		<hr>
	</header>
	<main class="flex-grow p-6 bg-gray-100">
	
	