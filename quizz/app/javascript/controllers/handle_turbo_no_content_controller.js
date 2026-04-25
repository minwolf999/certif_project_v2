// app/javascript/controllers/handle_turbo_no_content_controller.js
import { Controller } from "@hotwired/stimulus"

// This controller aim to handle the "No content" response from turbo
// this can happens when there is an error in the laoded frame or when the target frame isn't present
// instead of replacing the current frame with "NO CONTENT" message, it display a flash error
// it won't be triggered if there is an error inside the .turbo_stream file

export default class extends Controller {
  static targets = ["submitBtn"]

  connect() {
    document.addEventListener("turbo:frame-missing", (event) => {
      event.preventDefault()
      document.dispatchEvent(new CustomEvent('hidesavingscreen', { bubbles: true }))
      this.displayFlashMessage('Une erreur est survenue.')
    })
  }

  displayFlashMessage(message) {
    const notificationTemplate = `
      <div class="relative z-[100]">
        <div class="pointer-events-none fixed inset-0 flex items-end px-4 py-6 sm:items-start sm:p-6" aria-live="assertive">
          <div class="flex w-full flex-col items-center space-y-4 sm:items-end">
            <div class="opacity-0 pointer-events-auto w-full max-w-sm overflow-hidden rounded-lg shadow-lg transition-opacity duration-300 bg-red-50" data-controller="notification--toaster-component" data-notif-type="error">
              <div class="p-4">
                <div class="flex items-start">
                  <div class="flex-shrink-0">
                    <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.28 7.22a.75.75 0 00-1.06 1.06L8.94 10l-1.72 1.72a.75.75 0 101.06 1.06L10 11.06l1.72 1.72a.75.75 0 101.06-1.06L11.06 10l1.72-1.72a.75.75 0 00-1.06-1.06L10 8.94 8.28 7.22z" clip-rule="evenodd"></path>
                    </svg>
                  </div>
                  <div class="ml-3 w-0 flex-1 pt-0.5">
                    <p class="text-sm font-medium text-red-800">${message}</p>
                  </div>
                  <div class="ml-4 flex flex-shrink-0">
                    <button type="button" class="inline-flex rounded-md text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-primary-light focus:ring-offset-2" data-action="click->notification--toaster-component#close">
                      <span class="sr-only">Close</span>
                      <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path d="M6.28 5.22a.75.75 0 00-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 101.06 1.06L10 11.06l3.72 3.72a.75.75 0 101.06-1.06L11.06 10l3.72-3.72a.75.75 0 00-1.06-1.06L10 8.94 6.28 5.22z"></path>
                      </svg>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    `

    const tempDiv = document.createElement('div')
    tempDiv.innerHTML = notificationTemplate
    const notifications = document.getElementById("notifications")
    notifications.appendChild(tempDiv)
  }
}
