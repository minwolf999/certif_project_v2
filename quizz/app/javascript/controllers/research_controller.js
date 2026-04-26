import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"];

  submit() {
    const searchParams = new URLSearchParams(new FormData(this.formTarget));
    window.history.pushState({}, '', `${window.location.pathname}?${searchParams.toString()}`);

    this.formTarget.requestSubmit();
  }
}
