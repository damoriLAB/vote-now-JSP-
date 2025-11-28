<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
<script type="module"
	src="${pageContext.request.contextPath}/static/js/main.js"> </script>
</head>
<body>

<!-- Page Container -->
<div class="min-h-screen bg-white text-gray-900 px-4 sm:px-6 lg:px-8 pt-28 pb-20">

  <!-- HEADER DO USUÁRIO -->
  <section 
    class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-violet-500 via-fuchsia-500 to-orange-500 p-[2px] shadow-xl animate-fade-in">
    
    <div class="bg-white rounded-3xl p-8 sm:p-10 flex flex-col sm:flex-row items-center gap-6">
      
      <!-- Avatar -->
      <img 
        src="https://randomuser.me/api/portraits/men/32.jpg"
        class="w-28 h-28 rounded-full shadow-lg ring-4 ring-white object-cover animate-float-slow"
      />

      <!-- User info -->
      <div class="flex-1">
        <h1 class="text-3xl font-bold tracking-tight mb-1">João Ricardo</h1>
        <p class="text-gray-500">Membro desde 2023</p>
      </div>

      <!-- Botão Editar -->
      <a 
        href="/user/edit?id=123"
        class="px-5 py-2.5 rounded-xl bg-violet-600 text-white font-semibold shadow hover:bg-violet-700 active:scale-95 transition-all">
        Editar Perfil
      </a>
    </div>
  </section>

  <!-- SOBRE O USUÁRIO -->
  <section class="mt-12">
    <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
      <span class="w-2 h-2 bg-violet-600 rounded-full"></span>
      Sobre o Usuário
    </h2>

    <div class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm animate-slide-up">
      <p class="text-gray-700 leading-relaxed">
        João é um criador ativo de surveys dentro da plataforma. Trabalha como analista de sistemas
        e costuma criar enquetes sobre tecnologia, produtividade e tendências do mercado.
      </p>
    </div>
  </section>

  <!-- ÚLTIMAS SURVEYS CRIADAS PELO USUÁRIO -->
  <section class="mt-12">
    <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
      <span class="w-2 h-2 bg-fuchsia-600 rounded-full"></span>
      Últimas Surveys Criadas
    </h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

      <!-- CARD 1 -->
      <div 
        class="bg-white p-5 rounded-2xl border border-gray-200 shadow-sm hover:shadow-lg transition-shadow animate-card-fade">
        <h3 class="font-semibold text-lg mb-1">Preferências de IDE</h3>
        <p class="text-gray-500 text-sm mb-2">Criado em 04 Nov 2025</p>
        <p class="text-gray-600 line-clamp-2 mb-4">Qual IDE você utiliza para desenvolver em Java?</p>
        <a href="/survey/show?id=44" 
           class="text-violet-600 font-semibold hover:underline">Ver survey →</a>
      </div>

      <!-- CARD 2 -->
      <div 
        class="bg-white p-5 rounded-2xl border border-gray-200 shadow-sm hover:shadow-lg transition-shadow animate-card-fade delay-75">
        <h3 class="font-semibold text-lg mb-1">Framework favorito</h3>
        <p class="text-gray-500 text-sm mb-2">Criado em 28 Out 2025</p>
        <p class="text-gray-600 line-clamp-2 mb-4">Comparação entre frameworks modernos.</p>
        <a href="/survey/show?id=45" 
           class="text-violet-600 font-semibold hover:underline">Ver survey →</a>
      </div>

      <!-- CARD 3 -->
      <div 
        class="bg-white p-5 rounded-2xl border border-gray-200 shadow-sm hover:shadow-lg transition-shadow animate-card-fade delay-150">
        <h3 class="font-semibold text-lg mb-1">Banco preferido</h3>
        <p class="text-gray-500 text-sm mb-2">Criado em 15 Out 2025</p>
        <p class="text-gray-600 line-clamp-2 mb-4">MySQL, Postgres, Oracle, MariaDB… qual você prefere?</p>
        <a href="/survey/show?id=46" 
           class="text-violet-600 font-semibold hover:underline">Ver survey →</a>
      </div>
    </div>
  </section>

  <!-- ÚLTIMOS VOTOS DO USUÁRIO -->
  <section class="mt-12">
    <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
      <span class="w-2 h-2 bg-orange-600 rounded-full"></span>
      Últimos Votos
    </h2>

    <div class="space-y-5">
      
      <!-- ITEM 1 -->
      <div class="bg-white border border-gray-200 rounded-2xl p-5 shadow-sm animate-slide-up">
        <div class="flex justify-between items-center mb-2">
          <h3 class="font-semibold">Melhor linguagem do ano</h3>
          <span class="text-xs bg-violet-100 text-violet-700 px-3 py-1 rounded-full">3 dias atrás</span>
        </div>
        <p class="text-gray-600 text-sm">
          Votou em: <span class="font-semibold text-violet-600">Java</span>
        </p>
      </div>

      <!-- ITEM 2 -->
      <div class="bg-white border border-gray-200 rounded-2xl p-5 shadow-sm animate-slide-up delay-75">
        <div class="flex justify-between items-center mb-2">
          <h3 class="font-semibold">Banco de dados preferido</h3>
          <span class="text-xs bg-fuchsia-100 text-fuchsia-700 px-3 py-1 rounded-full">1 semana atrás</span>
        </div>
        <p class="text-gray-600 text-sm">
          Votou em: <span class="font-semibold text-fuchsia-600">PostgreSQL</span>
        </p>
      </div>

    </div>
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

</body>
</html>