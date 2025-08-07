import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-block"
export default class extends Controller {
  static targets = [ "updateSubmitButton", "createSubmitButton", "deleteSubmitButton", "editData" ]
  static values = { placeholder: Boolean }

  connect() {
    console.info("ContentBlockEditingController connected", this.element);
    console.debug("hasEditDataTarget:", this.hasEditDataTarget);
    console.debug("hasUpdateSubmitButtonTarget:", this.hasUpdateSubmitButtonTarget);
    console.debug("hasCreateSubmitButtonTarget:", this.hasCreateSubmitButtonTarget);
    console.debug("hasDeleteSubmitButtonTarget:", this.hasDeleteSubmitButtonTarget);
    console.debug("placeholderValue:", this.placeholderValue);
  }

  onKeyPress(event) {
    console.debug("Key pressed in content block editor", event.key, event.shiftKey)
    if (event.key === "Enter" && !event.shiftKey) {
      this.createSubmitButtonTarget.click();
      event.preventDefault();
    }
  }

  onInput(event) {
    console.debug("Input event in content block editor", event.target.innerHTML);
    if (this.hasEditDataTarget) {
      const data = event.target.innerHTML
      this.editDataTarget.value = data
    }
  }

  delete() {
    console.debug("Deleting content block", this.element);
    this.deleteSubmitButtonTarget.click();
  }

  get blockContent() {
    return this.editDataTarget.value
  }
}

