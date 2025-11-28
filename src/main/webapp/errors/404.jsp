<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Erro 404</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/dist.css">
<script type="module"
	src="${pageContext.request.contextPath}/static/js/main.js"> </script>
	
	
    <style>
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
</head>
<body class="min-h-screen flex items-center justify-center p-6"> 
    <div class="text-center bg-white/80 backdrop-blur-xl p-10 rounded-3xl shadow-2xl max-w-lg animate__animated animate__fadeIn">

        <!-- SVG de erro -->
        <div class="mb-6 w-full flex justify-center">
            <svg class='w-28 h-28 text-indigo-600' fill='none' stroke='currentColor' stroke-width='1.5' viewBox='0 0 24 24'>
        <path stroke-linecap='round' stroke-linejoin='round' d='M12 9v3m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z'/>
     </svg>
        </div>

        <h1 class="text-5xl font-extrabold text-gray-800 mb-3">
            404
        </h1>

        <p class="text-xl text-gray-700 font-medium mb-6">
            Página não encontrada
        </p>

        <a href="${pageContext.request.contextPath}/" 
           class="inline-block px-8 py-3 bg-indigo-600 text-white font-semibold rounded-xl shadow-lg hover:bg-indigo-700 transform hover:scale-[1.03] transition active:scale-95">
            Voltar para Home
        </a>

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