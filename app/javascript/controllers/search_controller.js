import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static values = {
    url: String
  }
  static outlets = [ "results" ]

  connect() {
    console.log(this.urlValue, this.hasResultsOutlet)
  }

  async run(e) {
    const searchTerms = e.target.value
    if (searchTerms.length <= 3)
      return

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content
    const res = await Turbo.fetch(this.urlValue, {
      method: "POST",
      body: JSON.stringify({
        search: {
          text: searchTerms,
        }
      }),
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
    })

    const results = await res.json()
    console.log(this.resultsOutlet)
  }
}
