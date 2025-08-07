import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-blocks"
export default class extends Controller {
  static targets = [ "content-block", "sanitizeSubmitButton" ]

  connect() {
    console.info("ContentBlocksController connected", this.element);
    console.debug("Content blocks:", this.contentBlockTargets);
    console.debug("Check sanity submit button target:", this.hasSanitizeSubmitButtonTarget);
  }
}
