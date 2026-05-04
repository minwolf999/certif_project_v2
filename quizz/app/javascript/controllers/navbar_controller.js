import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["navbar", "icon"];

  connect() {
    this.is_open = true;
    this.dimension = this.navbarTarget.offsetWidth - this.iconTarget.offsetWidth - 4;

    this.close();
  }

  toggle() {
    console.log(this.dimension);
    
    this.is_open = !this.is_open;
    this.is_open ? this.open() : this.close();
  }

  close() {
    this.navbarTarget.style.left = `-${this.dimension}px`;
    this.iconTarget.classList.replace('rotate-0', 'rotate-180');
  }
  
  open() {
    this.navbarTarget.style.left = '0px';
    this.iconTarget.classList.replace('rotate-180', 'rotate-0');
  }
}
