import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="heading"
export default class extends Controller {
  connect() {
    console.log("Hi")
  }
}
