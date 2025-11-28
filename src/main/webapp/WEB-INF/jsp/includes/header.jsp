<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Vote now</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
	

<script type="module" src="${pageContext.request.contextPath}/static/js/main.js"> </script>
   <link rel="icon" href="${pageContext.request.contextPath}/static/logo.svg" type="image/x-icon">
   
</head>
<body class="">
<nav class="fixed top-0 left-0 w-full z-50 backdrop-blur-lg bg-white/60 shadow-soft">
  <div class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">

    <!-- Logo -->
    <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2">
      <div class="w-8 h-8 rounded-lg bg-primary flex items-center justify-center text-white font-bold">
        V
      </div>
      <span class="font-semibold text-fg text-lg">Vote Now</span>
    </a>

    <!-- Navegação principal -->
    
    <ul class="hidden md:flex items-center gap-6 font-medium text-gray-700">
      <li><a href="${pageContext.request.contextPath}/home.jsp" 
      class="hover:text-primary transition">
      Home
      </a></li>
      
      <li><a 
      href="${pageContext.request.contextPath}/survey/create.jsp" 
      class="hover:text-primary transition">Criar Survey
      </a></li>
      
      <li><a 
      href="${pageContext.request.contextPath}/users/show.jsp?id=${userLogged.id}" 
      class="hover:text-primary transition">Meu perfil
      </a></li>
      
    </ul>

    <!-- Avatar do usuário / dropdown -->
    <div class="relative">
      <button
        id="avatarBtn"
        class="w-10 h-10 rounded-full overflow-hidden border-2 border-primary shadow-soft active:scale-95 transition"
      >
        <img src="${userLogged.iconURL}" class="w-full h-full object-cover" />
      </button>

      <!-- DROPDOWN -->
      <div
        id="avatarDropdown"
        class="hidden absolute right-0 mt-3 w-44 rounded-xl bg-white shadow-hard p-2 animate-pop"
      >
        <a href="${pageContext.request.contextPath}/users/show.jsp?id=${userLogged.id}"
         class="block p-2 rounded-lg text-gray-700 hover:bg-gray-100 transition">
         Meu Perfil
        </a>
        
        <a href="${pageContext.request.contextPath}/users/edit.jsp?id=${userLogged.id}" 
        class="block p-2 rounded-lg text-gray-700 hover:bg-gray-100 transition">
        Editar Perfil
        </a>
        
        
        <hr class="my-2 border-gray-200" />
        
        <a href="${pageContext.request.contextPath}/users/logout.jsp" 
        class="block p-2 rounded-lg text-danger hover:bg-danger/10 transition">
        Logout
        </a>
        
      </div>
    </div>

  </div>
</nav>
<main class="">
</html>