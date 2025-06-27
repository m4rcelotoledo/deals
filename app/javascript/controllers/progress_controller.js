import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    this.element.closest('.alert').querySelector('.btn-close').click()
  }
}
