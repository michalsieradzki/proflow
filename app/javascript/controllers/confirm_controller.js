import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "title", "message", "confirmBtn"]
  
  connect() {
    // Bootstrap jest dostępny globalnie, nie przez import
    this.bootstrapModal = new window.bootstrap.Modal(this.modalTarget)
    this.pendingAction = null
    console.log("Confirm controller connected")
  }
  
  show(event) {
    event.preventDefault()
    console.log("Show method called", event.currentTarget)
    
    // Pobierz dane z elementu który wywołał akcję
    const element = event.currentTarget
    const title = element.dataset.confirmTitle || "Confirm Action"
    const message = element.dataset.confirmMessage || "Are you sure you want to proceed?"
    const actionType = element.dataset.confirmType || "danger"
    
    console.log("Modal data:", { title, message, actionType })
    
    // Zapisz akcję do wykonania - używamy data-confirm-url jeśli istnieje, inaczej href
    this.pendingAction = {
      url: element.dataset.confirmUrl || element.href,
      method: element.dataset.confirmMethod || element.dataset.turboMethod || 'GET',
      csrfToken: document.querySelector('[name="csrf-token"]').content,
      actionType: actionType
    }
    
    console.log("Pending action:", this.pendingAction)
    
    // Ustaw treść modala
    this.titleTarget.innerHTML = `<i class="bi bi-exclamation-triangle text-warning me-2"></i>${title}`
    this.messageTarget.textContent = message
    
    // Ustaw odpowiedni styl przycisku
    this.confirmBtnTarget.className = `btn btn-${actionType}`
    
    // Ustaw ikonę i tekst przycisku w zależności od typu akcji
    let icon, text
    switch(actionType) {
      case 'danger':
        icon = 'bi-trash'
        text = 'Delete'
        break
      case 'warning':
        icon = 'bi-exclamation-triangle'
        text = 'Proceed'
        break
      default:
        icon = 'bi-check-circle'
        text = 'Confirm'
    }
    
    this.confirmBtnTarget.innerHTML = `<i class="bi ${icon} me-2"></i>${text}`
    
    // Pokaż modal
    console.log("Showing modal")
    this.bootstrapModal.show()
  }
  
  execute(event) {
    console.log("Execute method called")
    if (!this.pendingAction) {
      console.log("No pending action")
      return
    }
    
    const { url, method, csrfToken, actionType } = this.pendingAction
    console.log("Executing action:", { url, method })
    
    // Wyłącz przycisk żeby zapobiec wielokrotnemu kliknięciu
    const btn = event.currentTarget
    btn.disabled = true
    btn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Processing...'
    
    // Wykonaj akcję
    if (method.toUpperCase() === 'GET') {
      window.location.href = url
    } else {
      // Dla POST, PATCH, DELETE używamy fetch
      fetch(url, {
        method: method.toUpperCase(),
        headers: {
          'X-CSRF-Token': csrfToken,
          'Accept': 'text/html,application/xhtml+xml,application/xml',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      .then(response => {
        console.log("Response:", response)
        if (response.ok) {
          // Jeśli to jest redirect, podążmy za nim
          if (response.redirected) {
            window.location.href = response.url
          } else {
            // Odśwież stronę
            window.location.reload()
          }
        } else {
          throw new Error(`HTTP ${response.status}`)
        }
      })
      .catch(error => {
        console.error('Error:', error)
        alert('An error occurred. Please try again.')
        btn.disabled = false
        
        // Przywróć oryginalny tekst przycisku
        let icon = actionType === 'danger' ? 'bi-trash' : 'bi-check-circle'
        let text = actionType === 'danger' ? 'Delete' : 'Confirm'
        btn.innerHTML = `<i class="bi ${icon} me-2"></i>${text}`
      })
    }
    
    // Ukryj modal
    this.bootstrapModal.hide()
    this.pendingAction = null
  }
  
  disconnect() {
    console.log("Confirm controller disconnected")
    if (this.bootstrapModal) {
      this.bootstrapModal.dispose()
    }
  }
} 