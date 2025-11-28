<%@page import="com.zzorg.repository.OptionRepository"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="com.zzorg.repository.SurveyRepository"%>
<%@page import="com.zzorg.web.dto.NewSurveyForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ page import="com.zzorg.model.User"%>
<%@ page import="com.zzorg.model.Option"%>
<%@ page import="com.zzorg.model.Survey"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashSet"%>


<%

User user = (User) session.getAttribute("LoggedUser");

if (request.getMethod().equals("POST")) {

	NewSurveyForm form = new NewSurveyForm(request);

	if (form.validate()) {
		OptionRepository optionRepository = AppContext.daoFactory().optionRepository();
		SurveyRepository surveyRepository = AppContext.daoFactory().surveyRepository();
		Survey survey = Survey.builder()
				.title(form.getTitle())
				.description(form.getDescription())
				.user(user)
				.build();
		int surveyID = surveyRepository.insert(survey);
		
		survey.setId(surveyID);
		
		
		List<Option> surveyOptions = form.getOptions().stream().map(title -> {
			Option o =  Option.builder()
					.title(title)
					.survey(survey)
					.build();
			
			int oId = optionRepository.insert(o);
			o.setId(oId);
			
			return o;
		}).toList();



		survey.setOptions(surveyOptions);
		response.sendRedirect(request.getContextPath() + "/survey/show.jsp?id=" + survey.getId());
		return;

	}
	
	request.setAttribute("errors", form.getErrors());
	request.setAttribute("form", form);
}
%>



<jsp:include page="/WEB-INF/jsp/includes/header.jsp"></jsp:include>

<div class="min-h-screen bg-white text-gray-900 px-4 sm:px-6 lg:px-8 pt-28 pb-20">
  <!-- Header -->
  <div class="mb-10">
    <h1 class="text-3xl font-bold tracking-tight">Criar Nova Survey</h1>
    <p class="text-gray-500 mt-1">Defina título, descrição e as opções que os usuários poderão votar.</p>
  </div>

  <form action="${pageContext.request.contextPath}/survey/create.jsp" method="POST" class="space-y-10">

    <!-- CARD PRINCIPAL -->
    <section class="relative bg-gradient-to-r from-primary via-purple-100 to-blue-400
                    p-[2px] rounded-md shadow-xl animate-fade-in">
      <div class="bg-white rounded-md p-8">

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
              name="options"
              placeholder="Ex: Java"
              class="flex-1 border-gray-300 rounded-md px-4 py-2
                     focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-all"
            />

            <button type="button"
                    class="remove-option text-gray-400 hover:text-red-500 transition-all ">
              ✕
            </button>
          </div>

          <div class="option-item opacity-0 animate-slide-up flex items-center gap-3 bg-gray-50 border border-gray-200 rounded-xl p-3">
            <input
              type="text"
              name="options"
              placeholder="Ex: Kotlin"
              class="flex-1 border-gray-300 rounded-md px-4 py-2
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
    <div class="flex justify-center gap-4 pt-4">

      <a href="${pageContext.request.contextPath}/"
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
    
    			<c:if test="${not empty errors}">
				<c:forEach var="err" items="${errors}">
					<p class="msg-error"> - ${err}</p>
				</c:forEach>
			</c:if>

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
      <input type="text" name="options" placeholder="Nova opção"
             class="flex-1 border-gray-300 rounded-md px-4 py-2
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

<jsp:include page="/WEB-INF/jsp/includes/footer.jsp"></jsp:include>