import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Theme controller connected")
  }
  
  toggle(event) {
    event.preventDefault()
    
    const currentTheme = document.body.getAttribute('data-bs-theme')
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark'
    
    // Zmień theme na froncie natychmiast
    document.body.setAttribute('data-bs-theme', newTheme)
    
    // Zmień ikonę w przycisku
    const icon = event.target.querySelector('i') || event.target
    if (newTheme === 'dark') {
      icon.className = 'bi bi-sun'
    } else {
      icon.className = 'bi bi-moon'
    }
    
    // Wyślij request do serwera w tle - BEZ Content-Type JSON
    fetch('/toggle_theme', {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      }
    })
    .then(response => {
      if (!response.ok) {
        console.error('Failed to save theme preference')
        // Przywróć poprzedni stan w przypadku błędu
        document.body.setAttribute('data-bs-theme', currentTheme)
        if (currentTheme === 'dark') {
          icon.className = 'bi bi-sun'
        } else {
          icon.className = 'bi bi-moon'
        }
      } else {
        console.log('Theme saved successfully')
      }
    })
    .catch(error => {
      console.error('Theme toggle error:', error)
    })
  }
} 