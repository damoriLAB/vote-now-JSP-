/**
 * 
 */

export default class VotesList {
	
	
	constructor(selectorHtml, rota, id, limit){
		
		this.API_URL = "http://localhost:8080/vote-now/api"
		this.SRC_URL = "http://localhost:8080/vote-now"
		this.initURL = `${this.API_URL}/${rota}/${id}?limit=${limit}`
		console.log(this.container, selectorHtml)
		this.container = document.querySelector(selectorHtml);
		console.log(this.container, selectorHtml)
		this.votesContainer = null;
		
		
		this.currentPage = 1;
		this.next = null;
		this.prev = null;
		
		this.init(this.initURL)
	}
	
	async init(url){
		this.votesContainer = document.createElement("div");
		this.votesContainer.classList = "";
		
		this.container.appendChild(this.votesContainer);
		this.createButtons();
		
		const data = await this.getData(url);
		this.updateComponent(data);


		this.loadContent(data.data)
		
	}
	
	async getData(url) {
		const data = await fetch(url)
			.then(response => {
				if (!response.ok) throw new Error("Network error")

				return response.json();
			});
		return data
	}
	
	async nextPage(){
		if (this.next == null) return;

		const data = await this.getData(this.next)
		
		console.log(data, data.data.length)
		
		if (data.data = [ ]) return;

		this.removeContent()

		this.loadContent(data.data)

		this.updateComponent(data)
	}
	
	async prevPage() {
		
		if (this.prev == null) return;
		console.log(this.prev)
		
		const data = await this.getData(this.prev)
		console.log(data)
		


		this.removeContent()

		this.loadContent(data.data)

		this.updateComponent(data)
		
	}
	
	updateComponent(data){
		this.next = data.next ? this.API_URL+data.next : null;
		this.prev = data.prev ? this.API_URL+data.prev : null;
		this.currentPage = data.page;
	}
	
	async loadContent(votes) {
		for (const vt of votes) {
			this.createContent(vt)
		}
	}
	
	createContent (vote){
		const element = document.createElement("div")
		
		
		const html = `
		
		<!-- Card de voto -->
				<div
					class="flex gap-4 p-5 mb-3 border border-gray-200 rounded-xl shadow-sm bg-white animate-fade-in relative">
					<!-- Barra lateral colorida -->
					<div
						class="absolute left-0 top-0 h-full w-1 bg-primary rounded-l-xl"></div>

					<img src="${vote.user.iconURL}"
						class="w-12 h-12 rounded-full" />

					<div>
					<a href="${this.SRC_URL}/users/show.jsp?id=${vote.user.id}">
						<p class="font-medium text-gray-900">${vote.user.name}</p>
					</a>
						
						<p class="text-gray-600 text-sm">
							Votou em <span class="font-medium">${vote.option.title}</span>
							- <a href="${this.SRC_URL}/survey/show.jsp?id=${vote.survey.id}">
								<span class="font-bold"> ${vote.survey.title} </span>
							 </a>
						</p>
						<span
							class="text-xs bg-primary/10 text-primary px-2 py-1 rounded mt-1 inline-block">
							${ago(vote.createdAt)}</span>
					</div>
				</div>
		
		`
		
		element.innerHTML = html;
		
		this.votesContainer.appendChild(element)
		
	}
	
	createButtons() {
			const div = document.createElement("div")
			div.classList = "flex justify-center"
			const html = `
				
			<div id="containerBTNs" class="flex gap-5">
				<button id="prevPageBTN" class="border-b-2 " > Prev </button>
				<button id="nextPageBTN" class="border-b-2 "> Next </button>
			 </div>
			
			`
			div.innerHTML = html;

			const prevPageBTN = div.querySelector("#prevPageBTN")
			const nextPageBTN = div.querySelector("#nextPageBTN")


			div.addEventListener('click', e => {
				const target = e.target
				if (target == prevPageBTN) {
					this.prevPage()
				}
				if (target == nextPageBTN) {
					this.nextPage()
				}

			})

			this.container.appendChild(div)
		}
	
	removeContent() {
	
		this.votesContainer.innerHTML = " ";
	}
	
	
}

function ago(dateString) {
  const d = new Date(dateString);
  const s = (d - new Date()) / 1000;
  const rtf = new Intl.RelativeTimeFormat("pt-BR", { numeric: "auto" });
  const units = [
    ["year", 31536000],
    ["month", 2592000],
    ["week", 604800],
    ["day", 86400],
    ["hour", 3600],
    ["minute", 60],
    ["second", 1]
  ];
  for (const [unit, seconds] of units) {
    const v = Math.round(s / seconds);
    if (Math.abs(v) >= 1) return rtf.format(v, unit);
  }
  return "agora";
}
