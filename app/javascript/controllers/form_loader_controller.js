import { Controller } from "@hotwired/stimulus"
import KUTE from "kute.js"

// Connects to data-controller="form-loader"
export default class extends Controller {
  static targets = [ "icon" ]

  connect() {
    console.debug("hasIconTarget", this.hasIconTarget)

    this.loadingTween = KUTE.fromTo(this.iconTarget, {
      color: "#fafafa",
      rotate: 0
    }, {
      color: "#fafafa",
      rotate: 361,
    }, { duration: 1000, repeat: Infinity })
  }

  onSubmitStart() {
    if (this.clearLoadingTweenTimeout) {
      clearTimeout(this.clearLoadingTweenTimeout)
      this.clearLoadingTweenTimeout = undefined
    }

    console.log(this.loadingTween)
    if (this.loadingTween.paused)
      this.loadingTween.resume()
    else if (!this.loadingTween.playing)
      this.loadingTween.start()
  }

  onSubmitEnd(event) {
    if (this.clearLoadingTweenTimeout) {
      clearTimeout(this.clearLoadingTweenTimeout)
      this.clearLoadingTweenTimeout = undefined
    }

    console.log(event)

    const that = this
    this.clearLoadingTweenTimeout = setTimeout(() => {
      const success = event.detail.success
      const color = success ? "#05fa05" : "#fa0505"

      that.loadingTween.pause()

      KUTE.fromTo(that.iconTarget, { color }, { color: "#fafafa" }, { duration: 1000 }).start()

    }, 200)
  }
}
