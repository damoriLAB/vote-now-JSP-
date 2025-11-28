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
    <h1 class="text-3xl font-bold tracking-tight">Editar Perfil</h1>
    <p class="text-gray-500 mt-1">Atualize suas informações pessoais e foto de perfil.</p>
  </div>

  <form action="/user/update" method="POST" enctype="multipart/form-data" 
        class="space-y-10">

    <!-- CARD DE DADOS PESSOAIS -->
    <section class="relative bg-gradient-to-br from-violet-500 via-fuchsia-500 to-orange-500 
                    p-[2px] rounded-3xl shadow-xl animate-fade-in">
      <div class="bg-white rounded-3xl p-8">

        <!-- Foto do usuário -->
        <div class="flex items-center gap-6">
          <div class="relative">
            <img 
            id="avatarPreview"
              src="https://randomuser.me/api/portraits/women/44.jpg"
              class="w-28 h-28 rounded-full object-cover shadow-lg ring-4 ring-white animate-float-slow"
            />

            <!-- Botão trocar foto -->
            <label 
              for="avatar"
              class="absolute bottom-0 right-0 bg-violet-600 hover:bg-violet-700 
                     text-white p-2 rounded-full cursor-pointer shadow transition-all">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M15.232 5.232l3.536 3.536M10 4h4l3 3v4l-7 7H6l-3-3v-4l7-7z"/>
              </svg>
            </label>

            <input type="file" id="avatar" name="avatar" class="hidden" />
          </div>

          <div>
            <h2 class="text-xl font-semibold">Foto de Perfil</h2>
            <p class="text-gray-500 text-sm mt-1">
              Formatos permitidos: JPG, PNG — até 5MB.
            </p>
          </div>
        </div>

      </div>
    </section>

    <!-- FORMULÁRIO DE CAMPOS -->
    <section class="bg-white border border-gray-200 rounded-3xl p-8 shadow-sm animate-slide-up">

      <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">

        <!-- Nome -->
        <div class="flex flex-col">
          <label class="font-medium mb-1 text-gray-700">Nome</label>
          <input 
            type="text" 
            name="name"
            value="Maria Costa"
            class="border-gray-300 rounded-xl px-4 py-2.5 focus:ring-2 
                   focus:ring-violet-500 focus:border-violet-500 transition-all"
          />
        </div>

        <!-- Email -->
        <div class="flex flex-col">
          <label class="font-medium mb-1 text-gray-700">Email</label>
          <input 
            type="email" 
            name="email"
            value="maria.costa@example.com"
            class="border-gray-300 rounded-xl px-4 py-2.5 focus:ring-2 
                   focus:ring-fuchsia-500 focus:border-fuchsia-500 transition-all"
          />
        </div>

      </div>

      <!-- Bio -->
      <div class="mt-6">
        <label class="font-medium mb-1 block text-gray-700">Bio</label>
        <textarea
          name="bio"
          rows="4"
          class="border-gray-300 rounded-xl px-4 py-3 w-full resize-none 
                 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-all"
        >Criadora de surveys e analista de sistemas apaixonada por tecnologia.</textarea>
      </div>

    </section>


    <!-- BOTÕES -->
    <div class="flex justify-end gap-4 pt-4">

      <a href="/user/show?id=123"
         class="px-5 py-2.5 rounded-xl border border-gray-300 text-gray-700 font-medium 
                hover:bg-gray-50 active:scale-95 transition-all">
        Cancelar
      </a>

      <button
        type="submit"
        class="px-6 py-3 rounded-xl bg-violet-600 text-white font-semibold shadow-lg 
               hover:bg-violet-700 active:scale-95 transition-all">
        Salvar Alterações
      </button>

    </div>

  </form>
</div>

<script>
  const input = document.getElementById("avatar");
  const preview = document.getElementById("avatarPreview");

  input.addEventListener("change", function () {
    const file = this.files[0];
    if (!file) return;

    const reader = new FileReader();

    reader.onload = function (e) {
      preview.src = e.target.result;
      preview.classList.add("animate-pulse");
      setTimeout(() => preview.classList.remove("animate-pulse"), 400);
    };

    reader.readAsDataURL(file);
  });
</script>


<!-- Animations -->
<style>
  .animate-float-slow { animation: float 3s ease-in-out infinite; }
  .animate-fade-in { animation: fade-in 0.6s ease both; }
  .animate-slide-up { animation: slide-up 0.6s ease both; }

  @keyframes float {
    0% { transform: translateY(0); }
    50% { transform: translateY(-6px); }
    100% { transform: translateY(0); }
  }
  @keyframes fade-in { from { opacity: 0; } to { opacity: 1; } }
  @keyframes slide-up {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>

</body>
</html>