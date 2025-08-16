import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = [ "notification" ]

  connect() {
  }

  notificationTargetConnected(element) {
    // Optionally, you can add logic here to handle when a notification is added
    const delay = element.innerText.length * 80
    console.debug("Notification target connected", element, "Disappearing in", delay)

    // Remove it after a delay
    setTimeout(() => {
      this.removeNotification(element)
    }, delay) // Adjust the delay as needed
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
