<%@page import="com.zzorg.model.User"%>
<%@page import="com.zzorg.AppContext"%>
<%@page import="java.util.Optional"%>
<%@page import="com.zzorg.repository.UserRepository"%>
<%@page import="com.zzorg.web.dto.LoginForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%
// validar login
if (request.getMethod().equals("POST")) {

	LoginForm form = new LoginForm(request);

	if (form.validate()) {

		UserRepository userRepository = AppContext.daoFactory().userRepository();
		Optional<User> userOpt = userRepository.findByEmailAndPassword(form.getEmail(), form.getPassword());

		if (userOpt.isPresent()) {

			session.setAttribute("LoggedUser", userOpt.get());
			response.sendRedirect(request.getContextPath() + "/home.jsp");
			return;

		}
		
		form.getErrors().add("Usuario ou senha invalidos");

	}

	request.setAttribute("errors", form.getErrors());
	request.setAttribute("email", form.getEmail());
}
%>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Fça seu login</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
<script type="module"
	src="${pageContext.request.contextPath}/static/js/main.js"> </script>
</head>

<body class="min-h-screen flex items-center justify-center p-6">
    
    <div class="w-full max-w-md">

        <!-- 🟣 Card -->
        <div class="bg-white/80 backdrop-blur-xl shadow-2xl rounded-2xl p-8 animate__animated animate__fadeIn">

            <!-- 🔵 Ícone -->
            <div class="w-full flex justify-center mb-4">
                <div class="w-16 h-16 text-white rounded-full flex items-center justify-center  text-3xl font-bold">
                    <img src="${pageContext.request.contextPath}/static/logo.svg" width=100>
                </div>
            </div>

            <h1 class="text-3xl font-bold text-gray-800 text-center mb-6">
                Entrar na sua conta
            </h1>

            <!-- 📝 Form -->
            <form action="${pageContext.request.contextPath}/auth/login.jsp" method="post" class="space-y-5">

                <!-- Email -->
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Email</label>
                    <input 
                        type="email"
                        name="email"
                        value="${form.email}"
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
                        value="${form.password}"
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
            
            <c:forEach var="msg" items="${errors}">
				<p class="msg-error">${msg}</p>

			</c:forEach>

            <!-- Criar conta -->
            <p class="text-center text-gray-700 mt-6">
                Não tem uma conta?
                <a href="${pageContext.request.contextPath}/auth/register.jsp" class="text-indigo-600 hover:underline font-semibold">
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

<script>
document.addEventListener("DOMContentLoaded", () => {
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");

    canvas.style.position = "fixed";
    canvas.style.top = 0;
    canvas.style.left = 0;
    canvas.style.width = "100%";
    canvas.style.height = "100%";
    canvas.style.zIndex = "-1";
    canvas.style.pointerEvents = "none";

    document.body.appendChild(canvas);

    let w, h;
    function resize() {
        w = canvas.width = window.innerWidth;
        h = canvas.height = window.innerHeight;
    }
    resize();
    window.addEventListener("resize", resize);

    // Configuração das partículas
    const particles = Array.from({ length: 80 }).map(() => ({
        x: Math.random() * w,
        y: Math.random() * h,
        r: Math.random() * 2 + 1,
        dx: (Math.random() - 0.5) * 0.6,
        dy: (Math.random() - 0.5) * 0.6,
        color: ["#ffffff88", "#ffffff55", "#eeeeee66"][Math.floor(Math.random() * 3)]
    }));

    function animate() {
        ctx.clearRect(0, 0, w, h);

        // Atualiza e desenha cada partícula
        particles.forEach(p => {
            p.x += p.dx;
            p.y += p.dy;

            // Recoloca nas bordas
            if (p.x < 0 || p.x > w) p.dx *= -1;
            if (p.y < 0 || p.y > h) p.dy *= -1;

            ctx.beginPath();
            ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
            ctx.fillStyle = p.color;
            ctx.fill();
        });

        // Conectar partículas próximas (efeito elegante)
        for (let i = 0; i < particles.length; i++) {
            for (let j = i + 1; j < particles.length; j++) {
                const a = particles[i];
                const b = particles[j];
                const dist = Math.hypot(a.x - b.x, a.y - b.y);

                if (dist < 120) {
                    ctx.strokeStyle = "#ffffff22";
                    ctx.lineWidth = 1;
                    ctx.beginPath();
                    ctx.moveTo(a.x, a.y);
                    ctx.lineTo(b.x, b.y);
                    ctx.stroke();
                }
            }
        }

        requestAnimationFrame(animate);
    }

    animate();
});
</script>
</body>

</html>