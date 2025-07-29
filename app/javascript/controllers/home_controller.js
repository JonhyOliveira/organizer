import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = [ "fadein", "typein" ]

  connect() {
    this.typeinTarget.textContent = "‎ "

    this.fadeTitle(this.fadeinTarget)
      .then(() => this.typeText(this.typeinTarget))
  }

  typeText(textElem, typeSpeed = 100) {
    return new Promise((r, j) => {
      const finalText = textElem.attributes["data-finalText"].value
      let currentIndex = 0

      const interval = setInterval(() => {
        currentIndex += 1
        const currentText = finalText.substring(0, currentIndex)
        textElem.textContent = currentText

        if (currentText.length >= finalText.length) {
          clearInterval(interval)
          r()
        }
      }, typeSpeed)
    })

  }

  fadeTitle(titleElem, tickSpeed = 100) {
    return new Promise((r, j) => {
      titleElem.style.opacity = 0
      let oldOpacity = 0

      const interval = setInterval(() => {
        oldOpacity += 0.1
        titleElem.style.opacity = oldOpacity

        if (oldOpacity >= 1) {
          clearInterval(interval)
          r()
        }
      }, tickSpeed)
    })
  }
}
