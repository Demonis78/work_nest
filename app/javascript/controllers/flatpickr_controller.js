import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      mode: "range", 
      dateFormat: "Y-m-d",
      minDate: "today", 
    });
  }
}