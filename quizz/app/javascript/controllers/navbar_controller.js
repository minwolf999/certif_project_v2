import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["navbar", "icon"]

  connect() { this.is_open = true; }

  toggle() {
    this.is_open ? this.open() : this.close();
    this.is_open = !this.is_open;
  }

  open() {
    this.navbarTarget.classList.replace('opacity-100', 'opacity-0');
    this.iconTarget.classList.replace('rotate-0', 'rotate-180');
  }
  
  close() {
    this.navbarTarget.classList.replace('opacity-0', 'opacity-100');
    this.iconTarget.classList.replace('rotate-180', 'rotate-0');
  }
}
