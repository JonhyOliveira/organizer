import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-block--editing"
export default class extends Controller {
  connect() {
    this.editContent = this.element.getElementsByClassName("contents")
  }
}
