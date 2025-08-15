import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="agenda-item-tracker"
export default class extends Controller {
  static targets = [ "startTimeInput", "endTimeInput" ]

  connect() {
    console.debug("hasStartTimeInputTarget", this.hasStartTimeInputTarget)
    console.debug("hasEndTimeInputTarget", this.hasEndTimeInputTarget)
  }

  setStart() {
    this.startTimeInputTarget.value = this.dateToDateTimeLocalValue(new Date())
    this.dispatch("input")
  }

  setEnd() {
    this.endTimeInputTarget.value = this.dateToDateTimeLocalValue(new Date())
    this.dispatch("input")
  }

  reset() {
    if (confirm("Are you sure?")) {
      this.startTimeInputTarget.value = null
      this.endTimeInputTarget.value = null
      this.dispatch("input")
    }
  }

  /**
   *
   * @param {Date} date
   * @returns {String}
   */
  dateToDateTimeLocalValue(date) {
    let milisUTC = date.getTime() - date.getTimezoneOffset() * 60000
    // zero out milis
    milisUTC /= 1000
    milisUTC = Math.round(milisUTC)
    milisUTC *= 1000

    return (new Date(milisUTC).toISOString()).slice(0, -1);
  }
}
