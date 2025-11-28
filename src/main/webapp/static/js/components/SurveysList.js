/**
 * 
 */

// TODO: ! API URL HARD CODE

class SurveyList {

	constructor(divID, urlINIT) {
		this.prev = null;
		this.next = null;
		this.currentPage = 1;
		this.idHtml = `\#${divID}`
		this.container = document.querySelector(`\#${divID}`);
		this.surveysContainer = null;

		this.apiURL = 'http://localhost:8080/vote-now'
		this.init(urlINIT)
	}

	async init(url) {

		this.surveysContainer = document.createElement("div");
		this.surveysContainer.classList = "grid gap-6 sm:grid-cols-2 lg:grid-cols-3"

		this.container.appendChild(this.surveysContainer);
		this.montarBTNs()

		const data = await this.getData(url)
		this.next = data.next
		this.prev = data.prev

		this.loadData(data.data)

	}

	async getData(url) {
		const data = await fetch(url)
			.then(response => {
				if (!response.ok) throw new Error("Network error")

				return response.json();
			});
		return data
	}

	async loadData(surveys) {
		for (const srv of surveys) {
			this.montarHTML(srv)
		}
	}

	montarHTML(survey) {


		const element = document.createElement("div")
		
		
		const title = (survey.title.length > 35 ) ? survey.title.slice(0,35)+"..." : survey.title

		const html = `	
		<!-- CARD 1 -->
		<div class="p-6 rounded-xl bg-white shadow-soft hover:shadow-hard transition-all hover:scale-[1.02] animate-fade-in">
		  
		  <!-- Badge -->
		  <span class="px-3 py-1 text-sm font-semibold bg-primary/10 text-primary rounded-full mb-4 inline-block">
		    ${survey.status}
		  </span>

		  <a href="${this.apiURL}/survey/show.jsp?id=${survey.id}"> 
		  	<h3 class="text-xl font-semibold text-fg mb-2">${title}</h3>
		  </a>
		  
		  <p class="text-gray-600 mb-4">
		    ${survey.description}
		  </p>

		  <!-- Autor + Data -->
		  <div class="flex items-center gap-3">
		    <img src="${survey.user.iconURL}" class="w-10 h-10 rounded-full" />
		    <div>
		      <a href="${this.apiURL}/users/show.jsp?id=${survey.user.id}">
			  	<p class="text-sm font-semibold text-fg">${survey.user.name}</p> 
			  </a>
		      <p class="text-xs text-gray-500">Criado em ${survey.createdAt}</p>
		    </div>
		  </div>

		</div>

		`;

		element.innerHTML = html;
		this.surveysContainer.appendChild(element)

	}

	montarBTNs() {
		const div = document.createElement("div")
		div.classList = "flex justify-center p-5"
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

	async nextPage() {
		if (this.next == null) return;


		const data = await this.getData(this.apiURL + this.next)
		
		if(data.data.length == 0) return;

		this.removeSurveys()
		console.log(data)
		this.loadData(data.data)

		this.next = data.next
		this.prev = data.prev



	}


	async prevPage() {

		if (this.prev == null) return;


		const data = await this.getData(this.apiURL + this.prev)
		console.log(data)


		this.removeSurveys()
		console.log(data)
		this.loadData(data.data)

		this.next = data.next
		this.prev = data.prev

	}

	removeSurveys() {
		this.surveysContainer.innerHTML = " "
	}

}

export default SurveyList;




