// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "jquery"
import Rails from "@rails/ujs"
import * as bootstrap from "bootstrap"

Rails.start()
Turbo.start()
