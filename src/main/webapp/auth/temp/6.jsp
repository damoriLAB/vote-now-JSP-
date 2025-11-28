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
<div class="min-h-screen bg-white text-gray-900 px-4 sm:px-6 lg:px-8 pt-28 pb-20">

  <!-- Header -->
  <div class="mb-10">
    <h1 class="text-3xl font-bold tracking-tight">Criar Nova Survey</h1>
    <p class="text-gray-500 mt-1">Defina título, descrição e as opções que os usuários poderão votar.</p>
  </div>

  <form action="/survey/store" method="POST" class="space-y-10">

    <!-- CARD PRINCIPAL -->
    <section class="relative bg-gradient-to-r from-violet-500 via-fuchsia-500 to-orange-500 
                    p-[2px] rounded-3xl shadow-xl animate-fade-in">
      <div class="bg-white rounded-3xl p-8">

        <!-- TÍTULO -->
        <div class="mb-6">
          <label class="font-medium mb-1 block text-gray-700">Título</label>
          <input 
            type="text"
            name="title"
            placeholder="Ex: Qual linguagem você usa no backend?"
            class="w-full border-gray-300 rounded-xl px-4 py-2.5
                   focus:ring-2 focus:ring-violet-500 focus:border-violet-500 transition-all"
          />
        </div>

        <!-- DESCRIÇÃO -->
        <div class="mb-6">
          <label class="font-medium mb-1 block text-gray-700">Descrição</label>
          <textarea
            name="description"
            rows="4"
            placeholder="Explique um pouco sobre a sua survey..."
            class="w-full border-gray-300 rounded-xl px-4 py-3 resize-none
                   focus:ring-2 focus:ring-fuchsia-500 focus:border-fuchsia-500 transition-all"
          ></textarea>
        </div>

        <!-- OPÇÕES -->
        <div id="optionsContainer" class="space-y-4">

          <label class="font-medium text-gray-700 block">Opções</label>

          <!-- Opção padrão -->
          <div class="option-item opacity-0 animate-slide-up flex items-center gap-3 bg-gray-50 border border-gray-200 rounded-xl p-3">
            <input
              type="text"
              name="options[]"
              placeholder="Ex: Java"
              class="flex-1 border-gray-300 rounded-xl px-4 py-2
                     focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-all"
            />

            <button type="button"
                    class="remove-option text-gray-400 hover:text-red-500 transition-all">
              ✕
            </button>
          </div>

          <div class="option-item opacity-0 animate-slide-up flex items-center gap-3 bg-gray-50 border border-gray-200 rounded-xl p-3">
            <input
              type="text"
              name="options[]"
              placeholder="Ex: Kotlin"
              class="flex-1 border-gray-300 rounded-xl px-4 py-2
                     focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-all"
            />

            <button type="button"
                    class="remove-option text-gray-400 hover:text-red-500 transition-all">
              ✕
            </button>
          </div>

        </div>

        <!-- BOTÃO ADICIONAR OPÇÃO -->
        <button type="button"
                id="addOptionBtn"
                class="mt-4 px-4 py-2.5 rounded-xl bg-violet-600 text-white font-medium shadow
                       hover:bg-violet-700 active:scale-95 transition-all">
          + Adicionar Opção
        </button>

      </div>
    </section>

    <!-- BOTÕES -->
    <div class="flex justify-end gap-4 pt-4">

      <a href="/"
         class="px-5 py-2.5 rounded-xl border border-gray-300 text-gray-700 font-medium 
                hover:bg-gray-50 active:scale-95 transition-all">
        Cancelar
      </a>

      <button
        type="submit"
        class="px-6 py-3 rounded-xl bg-fuchsia-600 text-white font-semibold shadow-lg 
               hover:bg-fuchsia-700 active:scale-95 transition-all">
        Criar Survey
      </button>

    </div>

  </form>
</div>

<!-- ANIMAÇÕES -->
<style>
  .animate-fade-in { animation: fade-in 0.6s ease both; }
  .animate-slide-up { animation: slide-up 0.4s ease both; }

  @keyframes fade-in {
    from { opacity: 0; }
    to   { opacity: 1; }
  }

  @keyframes slide-up {
    from { opacity: 0; transform: translateY(8px); }
    to   { opacity: 1; transform: translateY(0); }
  }
</style>

<!-- JS PARA ADICIONAR/REMOVER OPÇÕES -->
<script>
  const container = document.getElementById("optionsContainer");
  const addBtn = document.getElementById("addOptionBtn");

  addBtn.addEventListener("click", () => {
    const div = document.createElement("div");
    div.className = "option-item animate-slide-up flex items-center gap-3 bg-gray-50 border border-gray-200 rounded-xl p-3";

    div.innerHTML = `
      <input type="text" name="options[]" placeholder="Nova opção"
             class="flex-1 border-gray-300 rounded-xl px-4 py-2
                    focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-all" />

      <button type="button"
              class="remove-option text-gray-400 hover:text-red-500 transition-all">✕</button>
    `;

    container.appendChild(div);

    div.querySelector(".remove-option").addEventListener("click", () => {
      div.classList.add("opacity-0", "transition-all");
      setTimeout(() => div.remove(), 200);
    });
  });

  // Remover opções existentes
  document.querySelectorAll(".remove-option").forEach(btn => {
    btn.addEventListener("click", function () {
      const item = this.parentElement;
      item.classList.add("opacity-0", "transition-all");
      setTimeout(() => item.remove(), 200);
    });
  });
</script>

</body>
</html>