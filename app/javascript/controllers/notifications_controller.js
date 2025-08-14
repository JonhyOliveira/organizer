import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = [ "notification" ]

  connect() {
    this.element
  }

  notificationTargetConnected(element) {
    console.debug("Notification target connected", element)
    // Optionally, you can add logic here to handle when a notification is added

    // Remove it after a delay
    setTimeout(() => {
      this.removeNotification(element)
    }, 10000) // Adjust the delay as needed
  }

  removeNotification(element) {
    console.debug("Removing notification", element)
    if (element) {
      element.remove()
    } else {
      console.warn("No notification element to remove")
    }
  }
}
