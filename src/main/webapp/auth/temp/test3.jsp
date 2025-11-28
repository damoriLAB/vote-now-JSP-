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
	<!-- PAGE WRAPPER -->
	<div class="min-h-screen flex flex-col bg-white text-gray-900">

		<!-- NAVBAR -->


		<!-- TOP GRADIENT (suave, vibrante, premium) -->
		<div
			class="absolute inset-x-0 top-0 h-72 bg-gradient-to-tr from-purple-500/25 via-pink-400/25 to-blue-400/25 blur-3xl opacity-40 pointer-events-none">
			</div>

		<!-- HERO -->
		<section class="py-16 px-6 relative">
			<div class="max-w-4xl mx-auto text-center animate-fade-in">
				<span
					class="inline-block px-4 py-1 rounded-full bg-purple-600/10 text-purple-700 font-medium text-sm">
					Survey pública </span>

				<h1 class="mt-6 text-4xl font-bold tracking-tight text-gray-900">
					Opinião sobre Tecnologia</h1>

				<p class="mt-3 text-gray-600">
					Criada por <span class="font-semibold text-gray-800">João
						Silva</span> • 12/10/2025
				</p>
			</div>
		</section>

		<!-- MAIN CONTENT -->
		<main
			class="flex-1 max-w-7xl mx-auto px-6 pb-16 grid md:grid-cols-3 gap-10 relative">

			<!-- COLUNA ESQUERDA (survey + votação) -->
			<div class="md:col-span-2 space-y-10">

				<!-- CARD DA SURVEY -->
				<div
					class="p-10 rounded-3xl shadow-md border border-gray-200 relative overflow-hidden animate-slide-up bg-white">

					<!-- Borda luminosa -->
					<div
						class="absolute inset-0 rounded-3xl border-2 border-transparent bg-gradient-to-br from-purple-500/30 via-pink-500/30 to-blue-500/30 opacity-40 -z-10"></div>

					<h2
						class="text-2xl font-semibold text-gray-900 flex items-center gap-2">
						<svg xmlns="http://www.w3.org/2000/svg"
							class="w-6 h-6 text-purple-600" fill="none" viewBox="0 0 24 24"
							stroke="currentColor">
                        <path stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3" />
                    </svg>
						Sobre esta survey
					</h2>

					<p class="mt-4 text-gray-600 leading-relaxed">Queremos saber
						qual tecnologia você mais gosta atualmente. Vote abaixo e veja a
						opinião da comunidade em tempo real!</p>

					<!-- Formulário -->
					<form method="POST" action="/survey/vote" class="mt-10 space-y-6">

						<div class="space-y-4">

							<!-- OPTION ITEM -->
							<label class="block group cursor-pointer">
								<div
									class="flex items-center gap-4 p-4 border border-gray-200 rounded-xl transition-all
                                        group-hover:border-purple-500/40 group-hover:bg-purple-50/40">
									<input type="checkbox" name="option" value="1"
										class="w-5 h-5 text-purple-600 rounded focus:ring-purple-500">

									<span class="font-medium text-gray-900 flex items-center gap-2">
										Java </span>
								</div>
							</label> <label class="block group cursor-pointer">
								<div
									class="flex items-center gap-4 p-4 border border-gray-200 rounded-xl transition-all
                                        group-hover:border-blue-500/40 group-hover:bg-blue-50/40">
									<input type="checkbox" name="option" value="2"
										class="w-5 h-5 text-blue-600 rounded focus:ring-blue-500">

									<span class="font-medium text-gray-900 flex items-center gap-2">
										JavaScript </span>
								</div>
							</label> <label class="block group cursor-pointer">
								<div
									class="flex items-center gap-4 p-4 border border-gray-200 rounded-xl transition-all
                                        group-hover:border-green-500/40 group-hover:bg-green-50/40">
									<input type="checkbox" name="option" value="3"
										class="w-5 h-5 text-green-600 rounded focus:ring-green-500">

									<span class="font-medium text-gray-900 flex items-center gap-2">
										Python </span>
								</div>
							</label>

						</div>

						<button
							class="mt-6 px-8 py-3 font-semibold text-white rounded-xl shadow-lg bg-gradient-to-r 
                               from-purple-600 via-pink-600 to-blue-600
                               hover:scale-105 active:scale-95 transition-all">
							Enviar voto</button>
					</form>
				</div>
			</div>



			<!-- COLUNA DIREITA — Últimos votos -->
			<div class="space-y-6 relative">

				<h3
					class="text-xl font-semibold text-gray-900 flex items-center gap-2">
					<svg xmlns="http://www.w3.org/2000/svg"
						class="w-5 h-5 text-blue-600" fill="none" viewBox="0 0 24 24"
						stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round"
							stroke-width="2" d="M14 10l-2 2m0 0l-2-2m2 2V6m0 6l2 2m-2-2l-2 2" />
                </svg>
					Últimos votos
				</h3>

				<div class="space-y-5">

					<!-- Card de voto -->
					<div
						class="flex gap-4 p-5 border border-gray-200 rounded-xl shadow-sm bg-white animate-fade-in relative">
						<!-- Barra lateral colorida -->
						<div
							class="absolute left-0 top-0 h-full w-1 bg-purple-500 rounded-l-xl"></div>

						<img src="https://i.pravatar.cc/50?img=12"
							class="w-12 h-12 rounded-full" />

						<div>
							<p class="font-medium text-gray-900">Maria Santos</p>
							<p class="text-gray-600 text-sm">
								Votou em <span class="font-medium">JavaScript</span>
							</p>
							<span
								class="text-xs bg-purple-100 text-purple-700 px-2 py-1 rounded mt-1 inline-block">
								2 min atrás </span>
						</div>
					</div>

					<div
						class="flex gap-4 p-5 border border-gray-200 rounded-xl shadow-sm bg-white animate-fade-in relative">
						<div
							class="absolute left-0 top-0 h-full w-1 bg-blue-500 rounded-l-xl"></div>

						<img src="https://i.pravatar.cc/50?img=8"
							class="w-12 h-12 rounded-full" />

						<div>
							<p class="font-medium text-gray-900">Carlos Lima</p>
							<p class="text-gray-600 text-sm">
								Votou em <span class="font-medium">Python</span>
							</p>
							<span
								class="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded mt-1 inline-block">
								15 min atrás </span>
						</div>
					</div>

					<div
						class="flex gap-4 p-5 border border-gray-200 rounded-xl shadow-sm bg-white animate-fade-in relative">
						<div
							class="absolute left-0 top-0 h-full w-1 bg-green-500 rounded-l-xl"></div>

						<img src="https://i.pravatar.cc/50?img=30"
							class="w-12 h-12 rounded-full" />

						<div>
							<p class="font-medium text-gray-900">Ana Souza</p>
							<p class="text-gray-600 text-sm">
								Votou em <span class="font-medium">Java</span>
							</p>
							<span
								class="text-xs bg-green-100 text-green-700 px-2 py-1 rounded mt-1 inline-block">
								1 hora atrás </span>
						</div>
					</div>
				</div>
			</div>




</main>
<div class="w-full px-4 sm:px-6 lg:px-8 mt-10">
  <div class="bg-white shadow-lg rounded-2xl p-6 border border-gray-200 w-full">
    <h2 class="text-2xl font-semibold text-gray-800 mb-4">
      Resultado Parcial
    </h2>
    <div class="h-72 w-full">
      <canvas id="surveyChart"></canvas>
    </div>
  </div>
</div>

	</div>

	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<script>
		// Exemplo: substitua pelos dados vindos do backend
		const optionLabels = [ "Opção A", "Opção B", "Opção C" ];
		const votesData = [ 12, 5, 9 ];

		const ctx = document.getElementById("surveyChart");

		new Chart(ctx, {
			type : "bar",
			data : {
				labels : optionLabels,
				datasets : [ {
					label : "Votos",
					data : votesData,
					backgroundColor : [ "#6366f1", // indigo
					"#10b981", // green
					"#f59e0b" // amber
					],
					borderColor : "#1f2937",
					borderWidth : 1,
					borderRadius : 10,
					barPercentage : 0.7,
					categoryPercentage : 0.6
				} ]
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				animation : {
					duration : 900,
					easing : "easeOutElastic"
				},
				scales : {
					y : {
						beginAtZero : true,
						ticks : {
							color : "#1f2937"
						},
						grid : {
							color : "#e5e7eb"
						}
					},
					x : {
						ticks : {
							color : "#1f2937"
						},
						grid : {
							display : false
						}
					}
				},
				plugins : {
					legend : {
						labels : {
							color : "#1f2937",
							font : {
								size : 14,
								weight : 600
							}
						}
					},
					tooltip : {
						backgroundColor : "#1f2937",
						titleColor : "#fff",
						bodyColor : "#fff",
						borderWidth : 0,
						padding : 10,
						bodyFont : {
							size : 14
						}
					}
				}
			}
		});
	</script>

	<!-- ANIMAÇÕES -->
	<style>
@
keyframes fade-in {
	from {opacity: 0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.animate-fade-in {
	animation: fade-in .6s ease forwards;
}

@
keyframes slide-up {
	from {opacity: 0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.animate-slide-up {
	animation: slide-up .6s ease forwards;
}
</style>


</body>
</html>