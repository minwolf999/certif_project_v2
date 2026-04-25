import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.classList.remove("opacity-0");

    if (this.element.dataset.notifType === "info" || this.element.dataset.notifType === "success") {
      setTimeout(() => { this.close() }, 4000);
    }
  }

  close() {
    this.element.classList.add("opacity-0");
    
    this.element.addEventListener("transitionend", () => {
      this.element.remove();
    });
  }
}
