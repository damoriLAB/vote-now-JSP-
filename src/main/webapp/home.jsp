<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/includes/header.jsp"></jsp:include>


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
        Olá, <span class="text-primary">${userLogged.name}</span> 👋  
        <br />
        Explore os surveys mais recentes!
      </h1>

      <p class="text-gray-600 text-lg mb-6 animate-fade-in" style="animation-delay:0.1s;">
        Descubra pesquisas de outros usuários, participe votando e gerencie suas próprias 
        de forma rápida e intuitiva.
      </p>

      <div class="flex gap-4">
        <a
          href="${pageContext.request.contextPath}/survey/create.jsp"
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

<section id="ultimos" class="max-w-6xl mx-auto px-6 pt-16 pb-5">

  <h2 class="text-3xl font-bold text-fg mb-6">Últimos Surveys Criados</h2>
  
  <div id="latestSurveys">
  
  </div>

</section>

<section id="MyLast" class="py-5 px-6 relative z-10">

  <h2 class="text-3xl font-bold text-fg mb-6">Suas Surveys </h2>
  
  <div id="MyLatestSurveys">
  
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


<script defer type="module">

import SurveyList from "./static/js/components/SurveysList.js"

new SurveyList("MyLatestSurveys", "http://localhost:8080/vote-now/api/surveys/user/${userLogged.id}?page=1&limit=3")

</script>
<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>