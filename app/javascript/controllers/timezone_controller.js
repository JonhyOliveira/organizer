import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timezone"
export default class extends Controller {
  static targets = [ "timezone" ]

  connect() {
    console.debug("TimezoneController connected", this.element)
    console.debug("hasTimezoneTarget", this.hasTimezoneTarget)

    this.timezoneTarget.value = Intl.DateTimeFormat().resolvedOptions().timeZone
  }


}
