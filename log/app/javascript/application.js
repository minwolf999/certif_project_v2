// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


const params = new URLSearchParams(window.location.search);
const token = params.get("token");

if (token) {
  window.history.replaceState({}, document.title, window.location.pathname);

  var date = new Date();
  date.setDate(date.getDate() + 1);

  document.cookie = `culture_g=Bearer ${token}; expires=${date}; path=/`;
}
