import { Controller } from "@hotwired/stimulus"

// Cancel an inline edit form: clears the Turbo Frame so it falls back to
// the original page content (the form was loaded into the frame via a link).
export default class extends Controller {
  cancel(event) {
    event.preventDefault()
    const frame = this.element.closest("turbo-frame")
    if (frame) {
      frame.src = null
      frame.removeAttribute("src")
      frame.reload?.()
    }
    // Fallback: reload the page so the original content reappears
    if (frame && typeof frame.reload !== "function") {
      window.location.reload()
    }
  }
}
