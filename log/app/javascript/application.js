// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


const params = new URLSearchParams(window.location.search);
const token = params.get("token");

if (token) {
  localStorage.setItem("jwt", token);
  window.history.replaceState({}, document.title, window.location.pathname);
}

// Ensuite, pour toutes les requêtes fetch :
const jwt = localStorage.getItem("jwt");

if (jwt) {
  window.fetch = (originalFetch => {
    return (...args) => {
      const [resource, config = {}] = args;
      config.headers = {
        ...(config.headers || {}),
        Authorization: `Bearer ${jwt}`
      };
      return originalFetch(resource, config);
    };
  })(window.fetch);
}
