import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-block"
export default class extends Controller {
  static targets = [ "updateSubmitButton", "createSubmitButton", "deleteSubmitButton", "downgradeSubmitButton",
    "editData", "contentHolder" ]
  static values = { placeholder: Boolean, age: String }

  connect() {
    console.info("ContentBlockEditingController connected", this.element);
    console.debug("hasEditDataTarget:", this.hasEditDataTarget);
    console.debug("hasUpdateSubmitButtonTarget:", this.hasUpdateSubmitButtonTarget);
    console.debug("hasCreateSubmitButtonTarget:", this.hasCreateSubmitButtonTarget);
    console.debug("hasDeleteSubmitButtonTarget:", this.hasDeleteSubmitButtonTarget);
    console.debug("hasDowngradeSubmitButtonTarget", this.hasDowngradeSubmitButtonTarget)
    console.debug("hasContentHolder", this.hasContentHolderTarget)
    console.debug("placeholderValue:", this.placeholderValue);
    console.debug("ageValue", this.ageValue)
  }

  onKeyPress(event) {
    console.debug("Key pressed in content block editor", event.key, event.shiftKey)
    if (event.key === "Enter" && !event.shiftKey) {
      this.createSubmitButtonTarget.click();
      event.preventDefault();
    }
  }

  onInput(event) {
    console.log("Received input event", event)
    if (this.saveTimeout)
      clearTimeout(this.saveTimeout)

    if (this.hasEditDataTarget) {
      const data = event.target.innerHTML
      this.editDataTarget.value = data
    }

    this.saveTimeout = setTimeout(() => {
      this.updateSubmitButtonTarget.click()
      console.debug("Submited form")
    }, 500)
  }

  focus() {
    console.log("focus", this.element)
    this.contentHolderTarget.focus()
  }

  showActionItems() {
    this.createSubmitButtonTarget.classList.remove("invisible")
    this.deleteSubmitButtonTarget.classList.remove("invisible")
  }

  hideActionItems() {
    this.createSubmitButtonTarget.classList.add("invisible")
    this.deleteSubmitButtonTarget.classList.add("invisible")
  }
}

