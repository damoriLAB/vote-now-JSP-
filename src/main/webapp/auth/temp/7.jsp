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

<body class="min-h-screen flex items-center justify-center p-6">
    
    <div class="w-full max-w-md">

        <!-- 🟣 Card -->
        <div class="bg-white/80 backdrop-blur-xl shadow-2xl rounded-2xl p-8 animate__animated animate__fadeIn">

            <!-- 🔵 Ícone -->
            <div class="w-full flex justify-center mb-4">
                <div class="w-16 h-16 bg-indigo-500 text-white rounded-full flex items-center justify-center shadow-lg text-3xl font-bold">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M5.121 17.804A9 9 0 1118.364 4.56M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                    </svg>
                </div>
            </div>

            <h1 class="text-3xl font-bold text-gray-800 text-center mb-6">
                Entrar na sua conta
            </h1>

            <!-- 📝 Form -->
            <form action="/login" method="post" class="space-y-5">

                <!-- Email -->
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Email</label>
                    <input 
                        type="email"
                        name="email"
                        required
                        class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-4 focus:ring-indigo-300 focus:border-indigo-500 transition"
                        placeholder="seuemail@gmail.com"
                    />
                </div>

                <!-- Senha -->
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Senha</label>
                    <input 
                        type="password"
                        name="password"
                        required
                        class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-4 focus:ring-indigo-300 focus:border-indigo-500 transition"
                        placeholder="••••••••"
                    />
                </div>

                <!-- Botão -->
                <button 
                    type="submit"
                    class="w-full py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold rounded-xl shadow-lg transform hover:scale-[1.02] transition active:scale-95"
                >
                    Entrar
                </button>
            </form>

            <!-- Criar conta -->
            <p class="text-center text-gray-700 mt-6">
                Não tem uma conta?
                <a href="/register" class="text-indigo-600 hover:underline font-semibold">
                    Criar nova conta
                </a>
            </p>
        </div>
        
            <style>
        /* 🌈 Gradiente animado global */
        body {
            background: linear-gradient(120deg, #6EE7B7, #3B82F6, #A78BFA);
            background-size: 400% 400%;
            animation: gradientFlow 12s ease infinite;
        }

        @keyframes gradientFlow {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
    </style>

    </div>


</body>
</html>