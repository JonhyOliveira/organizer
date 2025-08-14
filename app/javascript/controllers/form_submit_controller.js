import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  static targets = [ "submitButton" ]

  connect() {
    console.debug("FormSubmitController connected")
    console.debug("hasSubmitButtonTarget", this.hasSubmitButtonTarget)

    // Ensure the submit button is present
    if (!this.hasSubmitButtonTarget) {
      console.warn("No submit button target found")
    }
  }

  onInput(event) {
    // Handle input events if necessary
    console.info("Input event detected", event)
    this.submit()
  }

  submit() {
    if (this.submitTimeout) {
      clearTimeout(this.submitTimeout)
    }

    this.submitTimeout = setTimeout(() => {
      // Trigger form submission or any other action
      if (this.hasSubmitButtonTarget) {
        this.submitButtonTarget.click()
      } else {
        console.warn("No submit button target found")
      }
    }, 750)
  }
}
