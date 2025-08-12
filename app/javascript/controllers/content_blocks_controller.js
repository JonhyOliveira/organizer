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
      outlet.focus()

      if (!this.selectionStack)
        this.selectionStack = []
      this.selectionStack.push(outlet)
  }

  contentBlockOutletDisconnected(outlet, element) {
    if (!this.selectionStack)
      return

    this.selectionStack = this.selectionStack.filter((v) => v != outlet)

    if (this.selectionStack.length > 0)
      console.log(this.selectionStack)
  }
}
