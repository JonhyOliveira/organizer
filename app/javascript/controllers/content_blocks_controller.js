import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-blocks"
export default class extends Controller {
  static targets = [ "sanitizeSubmitButton" ]
  static outlets = [ "content-block" ]


  connect() {
    console.info("ContentBlocksController connected", this.element);
    console.debug("Content blocks:", this.contentBlockOutlets);
    console.debug("Check sanity submit button target:", this.hasSanitizeSubmitButtonTarget);
    this.selectionStack = []
  }

  contentBlockOutletConnected(outlet, element) {
    console.log("content-block-outlet-connected")
    if (outlet.ageValue < 10) {
      outlet.focus()
      this.selectionStack.push(outlet)
    }
  }

  contentBlockOutletDisconnected(outlet, element) {

  }
}
