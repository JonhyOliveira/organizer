import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="documents--render"
export default class extends Controller {
  static values = { url: String }
  static targets = [ "data" ]

  connect() {
    console.log("connected", this.element, this.dataTarget, this.urlValue)
    this.loadState()
  }

  loadState() {
    const data = this.decode(this.dataTarget.value)

    // TODO load document into HTML

  }

  encode(data) {
    if (typeof data == undefined)
      return undefined

    return btoa(data)
  }

  decode(data) {
    if (typeof data == undefined)
      return undefined

    if (typeof data === "string")
      return atob(data)
  }
}
