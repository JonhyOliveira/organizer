import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="agenda-item-range-selector"
export default class extends Controller {
  static targets = [ "startTimeRow", "endTimeRow" ]

  connect() {
    console.debug("hasStartTimeRow", this.hasStartTimeRowTarget)
    console.debug("hasEndTimeRow", this.hasEndTimeRowTarget)

    this.updateExecutionTimeVisibility()
  }

  onStartInput(event) {
    this.updateExecutionTimeVisibility()
  }

  updateExecutionTimeVisibility() {
    if (this.startTimeRowTarget.querySelector("input").value.length == 0)
      this.endTimeRowTarget.hidden = true
    else
      this.endTimeRowTarget.hidden = false
  }
}
