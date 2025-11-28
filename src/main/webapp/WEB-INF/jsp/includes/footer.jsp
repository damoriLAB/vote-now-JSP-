<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


</main>
<footer class="relative z-10 pt-20 border-t border-white/10 bg-gray-900/60 backdrop-blur-2xl">

  <div class="max-w-6xl mx-auto px-6 py-16">

    <div class="grid grid-cols-1 sm:grid-cols-3 gap-12">

      <!-- COLUNA 1: Sobre -->
      <div>
        <h3 class="text-lg font-semibold text-gray-100">
          VoteNow
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
    <div class="mt-14 pt-6 border-t border-white/10 flex justify-between text-white text-sm">

      <span>© 2025 VoteNow — Todos os direitos reservados.</span>

      <span class="hidden sm:block">
        Construído com ❤️ por Damori
      </span>

    </div>

  </div>

</footer>

</body>
</html>