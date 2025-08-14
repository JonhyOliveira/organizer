import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="agenda-item-range-selector"
export default class extends Controller {
  static targets = [ "doByStartRow", "doByEndRow" ]

  connect() {
    console.debug("hasDoByStartRow", this.hasDoByStartRow)
    console.debug("hasDoByEndRow", this.hasDoByEndRow)

    this.updateDoTimeVisibility()
  }

  onDoByStartInput(event) {
    this.updateDoTimeVisibility()
  }

  updateDoTimeVisibility() {
    if (this.doByStartRowTarget.querySelector("input").value.length == 0)
      this.doByEndRowTarget.hidden = true
    else
      this.doByEndRowTarget.hidden = false
  }
}
