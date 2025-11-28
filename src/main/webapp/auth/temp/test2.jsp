<%@page import="com.zzorg.model.Vote"%>
<%@page import="java.util.List"%>
<%@page import="com.zzorg.repository.VoteRepository"%>
<%@page import="com.zzorg.model.Survey"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.SurveyRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%
SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();


Optional<Survey> survey = surveyRepository.findById(2);

VoteRepository voteRepository = AppContext.daoFactory().voteRepository();

List<Vote> votesSurvey1 = voteRepository.findBySurveyId(1, 0, 10);

request.setAttribute("survey", survey.get());
request.setAttribute("votes", votesSurvey1);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
</head>
<body class="bg-outro1">
<!-- NAVBAR -->
<nav class="fixed top-0 left-0 w-full z-50 backdrop-blur-lg bg-white/60 shadow-soft">
  <div class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">

    <!-- Logo -->
    <a href="/" class="flex items-center gap-2">
      <div class="w-8 h-8 rounded-lg bg-primary flex items-center justify-center text-white font-bold">
        V
      </div>
      <span class="font-semibold text-fg text-lg">Vote Now</span>
    </a>

    <!-- Navegação principal -->
    <ul class="hidden md:flex items-center gap-6 font-medium text-gray-700">
      <li><a href="#" class="hover:text-primary transition">Home</a></li>
      <li><a href="#" class="hover:text-primary transition">Criar Survey</a></li>
      <li><a href="#" class="hover:text-primary transition">Minhas Surveys</a></li>
    </ul>

    <!-- Avatar do usuário / dropdown -->
    <div class="relative">
      <button
        id="avatarBtn"
        class="w-10 h-10 rounded-full overflow-hidden border-2 border-primary shadow-soft active:scale-95 transition"
      >
        <img src="https://i.pravatar.cc/300?img=12" class="w-full h-full object-cover" />
      </button>

      <!-- DROPDOWN -->
      <div
        id="avatarDropdown"
        class="hidden absolute right-0 mt-3 w-44 rounded-xl bg-white shadow-hard p-2 animate-pop"
      >
        <a href="#" class="block p-2 rounded-lg text-gray-700 hover:bg-gray-100 transition">Meu Perfil</a>
        <a href="#" class="block p-2 rounded-lg text-gray-700 hover:bg-gray-100 transition">Editar Perfil</a>
        <a href="#" class="block p-2 rounded-lg text-gray-700 hover:bg-gray-100 transition">Minhas Surveys</a>
        <hr class="my-2 border-gray-200" />
        <a href="#" class="block p-2 rounded-lg text-danger hover:bg-danger/10 transition">Logout</a>
      </div>
    </div>

  </div>
</nav>

<section class="relative mt-16 overflow-hidden">

  <!-- BACKGROUND ORBS -->
  <div class="absolute inset-0 -z-10 opacity-40 blur-3xl">
    <div class="absolute top-[-50px] left-[10%] w-80 h-80 bg-primary rounded-full mix-blend-multiply animate-[spin_20s_linear_infinite]"></div>
    <div class="absolute bottom-[-60px] right-[15%] w-96 h-96 bg-accent rounded-full mix-blend-multiply animate-[spin_25s_linear_reverse_infinite]"></div>
  </div>

  <!-- CONTENT -->
  <div class="max-w-6xl mx-auto px-6 py-20">

    <div class="max-w-2xl">
      <h1 class="text-4xl md:text-5xl font-bold text-fg mb-4 leading-tight animate-fade-in">
        Olá, <span class="text-primary">Lucas</span> 👋  
        <br />
        Explore os surveys mais recentes!
      </h1>

      <p class="text-gray-600 text-lg mb-6 animate-fade-in" style="animation-delay:0.1s;">
        Descubra pesquisas de outros usuários, participe votando e gerencie suas próprias 
        de forma rápida e intuitiva.
      </p>

      <div class="flex gap-4">
        <a
          href="#"
          class="px-5 py-3 rounded-lg bg-primary text-white font-semibold shadow-soft hover:bg-primary-dark transition-all active:scale-95 animate-pop"
          style="animation-delay:0.15s;"
        >
          Criar novo survey
        </a>

        <a
          href="#ultimos"
          class="px-5 py-3 rounded-lg bg-white text-primary font-semibold border border-primary shadow-soft hover:bg-primary/10 transition-all active:scale-95 animate-pop"
          style="animation-delay:0.18s;"
        >
          Ver últimos
        </a>
      </div>
    </div>

  </div>
</section>


<!-- SECTION: Últimos Surveys Criados -->
<section id="ultimos" class="max-w-6xl mx-auto px-6 py-16">

  <h2 class="text-3xl font-bold text-fg mb-6">Últimos Surveys Criados</h2>

  <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">

    <!-- CARD 1 -->
    <div class="p-6 rounded-xl bg-white shadow-soft hover:shadow-hard transition-all hover:scale-[1.02] animate-fade-in">
      
      <!-- Badge -->
      <span class="px-3 py-1 text-sm font-semibold bg-primary/10 text-primary rounded-full mb-4 inline-block">
        Ativo
      </span>

      <h3 class="text-xl font-semibold text-fg mb-2">Satisfação com o Produto</h3>
      <p class="text-gray-600 mb-4">
        Uma pesquisa rápida para entender o nível de satisfação dos clientes com novos recursos do app.
      </p>

      <!-- Autor + Data -->
      <div class="flex items-center gap-3">
        <img src="https://i.pravatar.cc/300?img=33" class="w-10 h-10 rounded-full" />
        <div>
          <p class="text-sm font-semibold text-fg">Ana Barbosa</p>
          <p class="text-xs text-gray-500">Criado em 22/10/2025</p>
        </div>
      </div>

    </div>

    <!-- CARD 2 -->
    <div class="p-6 rounded-xl bg-white shadow-soft hover:shadow-hard transition-all hover:scale-[1.02] animate-fade-in" style="animation-delay:0.05s;">
      
      <span class="px-3 py-1 text-sm font-semibold bg-accent/10 text-accent rounded-full mb-4 inline-block">
        Em votação
      </span>

      <h3 class="text-xl font-semibold text-fg mb-2">Preferências de Filme</h3>
      <p class="text-gray-600 mb-4">
        Uma pesquisa divertida perguntando sobre gêneros e filmes favoritos dos usuários.
      </p>

      <div class="flex items-center gap-3">
        <img src="https://i.pravatar.cc/300?img=47" class="w-10 h-10 rounded-full" />
        <div>
          <p class="text-sm font-semibold text-fg">Bruno Silveira</p>
          <p class="text-xs text-gray-500">Criado em 20/10/2025</p>
        </div>
      </div>

    </div>

    <!-- CARD 3 -->
    <div class="p-6 rounded-xl bg-white shadow-soft hover:shadow-hard transition-all hover:scale-[1.02] animate-fade-in" style="animation-delay:0.1s;">
      
      <span class="px-3 py-1 text-sm font-semibold bg-danger/10 text-danger rounded-full mb-4 inline-block">
        Fechado
      </span>

      <h3 class="text-xl font-semibold text-fg mb-2">Opinião sobre o Novo Design</h3>
      <p class="text-gray-600 mb-4">
        Coletando feedback geral sobre a nova interface implementada no último update.
      </p>

      <div class="flex items-center gap-3">
        <img src="https://i.pravatar.cc/300?img=21" class="w-10 h-10 rounded-full" />
        <div>
          <p class="text-sm font-semibold text-fg">Marcos Lima</p>
          <p class="text-xs text-gray-500">Criado em 18/10/2025</p>
        </div>
      </div>

    </div>

  </div>
</section>


<section class="py-16 px-6 relative z-10">
  <div class="max-w-6xl mx-auto">

    <h2 class="text-3xl font-bold mb-8 tracking-tight text-gray-900">
      Suas Surveys
    </h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

      <!-- CARD 1 -->
      <article class="survey-card opacity-0 translate-y-4 transition-all duration-700 
        bg-gray-900/70 backdrop-blur-xl rounded-2xl border border-white/10 p-5 shadow-xl
        hover:scale-[1.02] hover:border-white/20 hover:shadow-2xl cursor-pointer">

        <h3 class="text-xl font-bold bg-clip-text text-transparent 
          bg-gradient-to-r from-pink-400 to-yellow-300">
          Qual linguagem você prefere em 2025?
        </h3>

        <p class="text-gray-300 mt-2 text-sm">
          Uma enquete para saber quais linguagens estão dominando este ano.
        </p>

        <div class="mt-4 flex items-center gap-3 text-gray-400 text-xs">
          <img src="/static/mock/user1.png"
            class="w-8 h-8 rounded-full border border-white/20" />
          <span>Criado por João Silva · 2 horas atrás</span>
        </div>

      </article>

      <!-- CARD 2 -->
      <article class="survey-card opacity-0 translate-y-4 transition-all duration-700 
        bg-gray-900/70 backdrop-blur-xl rounded-2xl border border-white/10 p-5 shadow-xl
        hover:scale-[1.02] hover:border-white/20 hover:shadow-2xl cursor-pointer">

        <h3 class="text-xl font-bold bg-clip-text text-transparent 
          bg-gradient-to-r from-green-300 to-lime-400">
          Qual sistema operacional você usa para programar?
        </h3>

        <p class="text-gray-300 mt-2 text-sm">
          Vote entre Linux, Windows, macOS ou outro.
        </p>

        <div class="mt-4 flex items-center gap-3 text-gray-400 text-xs">
          <img src="/static/mock/user2.png"
            class="w-8 h-8 rounded-full border border-white/20" />
          <span>Criado por Marina Costa · 5 horas atrás</span>
        </div>

      </article>

      <!-- CARD 3 -->
      <article class="survey-card opacity-0 translate-y-4 transition-all duration-700 
        bg-gray-900/70 backdrop-blur-xl rounded-2xl border border-white/10 p-5 shadow-xl
        hover:scale-[1.02] hover:border-white/20 hover:shadow-2xl cursor-pointer">

        <h3 class="text-xl font-bold bg-clip-text text-transparent 
          bg-gradient-to-r from-blue-300 to-purple-400">
          Você pretende migrar para IA generativa em seus projetos?
        </h3>

        <p class="text-gray-300 mt-2 text-sm">
          Uma pesquisa rápida sobre tendências em desenvolvimento moderno.
        </p>

        <div class="mt-4 flex items-center gap-3 text-gray-400 text-xs">
          <img src="/static/mock/user3.png"
            class="w-8 h-8 rounded-full border border-white/20" />
          <span>Criado por Carlos Lima · 8 horas atrás</span>
        </div>

      </article>

    </div>
  </div>
</section>


<!-- HERO SECTION -->
<section
  class="relative overflow-hidden py-20 px-6 border-b border-white/10"
>

  <!-- Fundo animado vibrante -->
  <div class="absolute inset-0 -z-10 animate-gradient bg-[linear-gradient(115deg,#ff4d4d,#ffdb4d,#4dff88,#4dc3ff,#b84dff)] bg-[length:400%_400%] opacity-30"></div>

  <!-- Conteúdo -->
  <div class="max-w-5xl mx-auto text-center">

    <h1 class="text-4xl md:text-6xl font-bold tracking-tight text-gray-900/60 drop-shadow-lg">
      Descubra, Vote e Crie Surveys de um Jeito Simples
    </h1>

    <p class="mt-6 text-lg md:text-xl text-gray-600 max-w-3xl mx-auto">
      Participe das votações ativas, explore novas pesquisas da comunidade ou
      crie suas próprias perguntas com apenas alguns cliques.
    </p>

    <!-- Botões -->
    <div class="mt-10 flex flex-col sm:flex-row justify-center gap-4">

      <a
        href="/survey/create"
        class="px-6 py-3 rounded-xl bg-white text-gray-900 font-medium shadow-lg shadow-black/20 
        hover:scale-[1.03] active:scale-95 transition-all duration-200"
      >
        Criar nova Survey
      </a>

      <a
        href="/surveys"
        class="px-6 py-3 rounded-xl bg-gray-900/60 text-white font-medium backdrop-blur-sm border border-white/20
        hover:bg-gray-900/80 hover:scale-[1.03] active:scale-95 transition-all duration-200"
      >
        Ver Todas as Surveys
      </a>

    </div>
  </div>
</section>

<footer class="relative z-10 pt-20 border-t border-white/10 bg-gray-900/60 backdrop-blur-2xl">

  <div class="max-w-6xl mx-auto px-6 py-16">

    <div class="grid grid-cols-1 sm:grid-cols-3 gap-12">

      <!-- COLUNA 1: Sobre -->
      <div>
        <h3 class="text-lg font-semibold text-gray-100">
          SurveyApp
        </h3>

        <p class="text-gray-400 text-sm mt-3 leading-relaxed">
          Crie enquetes, participe de votações e descubra opiniões da comunidade
          em tempo real. Simples, rápido e moderno.
        </p>
      </div>

      <!-- COLUNA 2: Links -->
      <div>
        <h3 class="text-lg font-semibold text-gray-100">Navegação</h3>

        <ul class="mt-4 space-y-2">
          <li>
            <a href="/"
               class="text-gray-400 hover:text-white transition
               hover:bg-gradient-to-r hover:from-pink-400 hover:to-yellow-300 hover:bg-clip-text hover:text-transparent">
              Home
            </a>
          </li>

          <li>
            <a href="/surveys"
               class="text-gray-400 hover:text-white transition
               hover:bg-gradient-to-r hover:from-green-300 hover:to-lime-400 hover:bg-clip-text hover:text-transparent">
              Explorar Surveys
            </a>
          </li>

          <li>
            <a href="/survey/create"
               class="text-gray-400 hover:text-white transition
               hover:bg-gradient-to-r hover:from-blue-400 hover:to-purple-400 hover:bg-clip-text hover:text-transparent">
              Criar Survey
            </a>
          </li>

          <li>
            <a href="/user/show.jsp"
               class="text-gray-400 hover:text-white transition
               hover:bg-gradient-to-r hover:from-amber-300 hover:to-orange-400 hover:bg-clip-text hover:text-transparent">
              Meu Perfil
            </a>
          </li>
        </ul>
      </div>

      <!-- COLUNA 3: Social -->
      <div>
        <h3 class="text-lg font-semibold text-gray-100">Redes</h3>

        <div class="mt-4 flex gap-5">

          <!-- GitHub -->
          <a href="#" class="text-gray-400 hover:text-white transition">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6"
              fill="currentColor" viewBox="0 0 24 24">
              <path d="M12 .3a12 12 0 0 0-3.8 23.4c.6.1.8-.3.8-.6v-2.2c-3.3.7-4-1.4-4-1.4-.5-1.1-1.2-1.4-1.2-1.4-1-.7.1-.7.1-.7 1.1.1 1.7 1.1 1.7 1.1 1 .1.7 2.7 2.7 3.2.3-.7.6-1.1.8-1.4-2.6-.3-5.3-1.3-5.3-5.8 0-1.2.4-2.2 1.1-3-.1-.3-.5-1.4.1-3 0 0 .9-.3 3 1.1a10 10 0 0 1 5.5 0c2.2-1.4 3-1.1 3-1.1.6 1.6.2 2.7.1 3a4.6 4.6 0 0 1 1.1 3c0 4.6-2.7 5.5-5.3 5.8.6.5 1 1.4 1 2.8v4c0 .3.2.7.8.6A12 12 0 0 0 12 .3"/>
            </svg>
          </a>

          <!-- Twitter -->
          <a href="#" class="text-gray-400 hover:text-white transition">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6"
              fill="currentColor" viewBox="0 0 24 24">
              <path d="M22 5.9c-.8.4-1.6.6-2.4.8.8-.6 1.5-1.4 1.8-2.4-.8.5-1.8.9-2.8 1-1.6-1.7-4.3-1.5-5.8.4a4 4 0 0 0-.8 2.6v.8A11.5 11.5 0 0 1 3 4.9c-.5.9-.7 2-.4 3.1.4 1.1 1.2 2 2.2 2.5-.7 0-1.4-.2-2-.5v.1c0 1.7 1.3 3.2 3 3.7-.3.1-.6.1-.9.1h-.7c.5 1.4 1.9 2.4 3.4 2.4A8.2 8.2 0 0 1 2 18.4a11.5 11.5 0 0 0 6.3 1.8c6.9 0 11.5-5.8 11.5-11.5V8a7.2 7.2 0 0 0 2.2-2.1c-.8.3-1.6.5-2.4.6z"/>
            </svg>
          </a>

          <!-- Instagram -->
          <a href="#" class="text-gray-400 hover:text-white transition">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6"
              fill="currentColor" viewBox="0 0 24 24">
              <path d="M7 2C4.2 2 2 4.2 2 7v10c0 2.8 2.2 5 5 5h10c2.8 0 5-2.2 5-5V7c0-2.8-2.2-5-5-5H7zm10 2c1.7 0 3 1.3 3 3v10c0 1.7-1.3 3-3 3H7c-1.7 0-3-1.3-3-3V7c0-1.7 1.3-3 3-3h10zm-5 3.3a4.7 4.7 0 1 0 0 9.4 4.7 4.7 0 0 0 0-9.4zm0 2a2.7 2.7 0 1 1 0 5.4 2.7 2.7 0 0 1 0-5.4zm4.8-.5a1.1 1.1 0 1 0-.002-2.202A1.1 1.1 0 0 0 16.8 8.8z"/>
            </svg>
          </a>

        </div>

      </div>
    </div>

    <!-- Linha final -->
    <div class="mt-14 pt-6 border-t border-white/10 flex justify-between text-gray-500 text-sm">

      <span>© 2025 SurveyApp — Todos os direitos reservados.</span>

      <span class="hidden sm:block">
        Construído com ❤️ por Damori
      </span>

    </div>

  </div>

</footer>


<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".survey-card").forEach((card, i) => {
      setTimeout(() => {
        card.classList.remove("opacity-0", "translate-y-4");
      }, i * 120);
    });
  });
</script>


<!-- ANIMAÇÃO DO GRADIENTE -->
<style>
  @keyframes gradient {
    0% {background-position: 0% 50%;}
    50% {background-position: 100% 50%;}
    100% {background-position: 0% 50%;}
  }
  .animate-gradient {
    animation: gradient 12s ease infinite;
  }
</style>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const cards = document.querySelectorAll(".survey-card");
    cards.forEach((card, i) => {
      setTimeout(() => {
        card.classList.remove("opacity-0", "translate-y-4");
      }, i * 120); // delay em cascata
    });
  });
</script>


<!-- SCRIPT dropdown -->
<script>
  const btn = document.getElementById("avatarBtn");
  const menu = document.getElementById("avatarDropdown");

  btn.addEventListener("click", () => {
    menu.classList.toggle("hidden");
  });

  // clicar fora fecha
  document.addEventListener("click", (e) => {
    if (!btn.contains(e.target) && !menu.contains(e.target)) {
      menu.classList.add("hidden");
    }
  });
</script>

</body>
</html>