import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="agenda-item-range-selector"
export default class extends Controller {
  static targets = [ "startTimeRow", "endTimeRow", "doByStartRow", "doByEndRow" ]

  connect() {
    console.debug("hasStartTimeRow", this.hasStartTimeRowTarget)
    console.debug("hasEndTimeRow", this.hasEndTimeRowTarget)
    console.debug("hasDoByStartRow", this.hasDoByStartRow)
    console.debug("hasDoByEndRow", this.hasDoByEndRow)

    this.updateExecutionTimeVisibility()
    this.updateDoTimeVisibility()
  }

  onStartInput(event) {
    this.updateExecutionTimeVisibility()
  }

  onDoByStartInput(event) {
    this.updateDoTimeVisibility()
  }

  updateExecutionTimeVisibility() {
    if (this.startTimeRowTarget.querySelector("input").value.length == 0)
      this.endTimeRowTarget.hidden = true
    else
      this.endTimeRowTarget.hidden = false
  }

  updateDoTimeVisibility() {
    if (this.doByStartRowTarget.querySelector("input").value.length == 0)
      this.doByEndRowTarget.hidden = true
    else
      this.doByEndRowTarget.hidden = false
  }
}
