class ThemeController < ApplicationController
  def toggle
    if user_signed_in?
      # Debugowanie
      Rails.logger.info "Current user theme: #{current_user.theme}"

      new_theme = current_user.dark? ? "light" : "dark"

      Rails.logger.info "Setting new theme: #{new_theme}"

      if current_user.update(theme: new_theme)
        Rails.logger.info "Theme updated successfully to: #{current_user.reload.theme}"
        head :ok
      else
        Rails.logger.error "Failed to update theme: #{current_user.errors.full_messages}"
        head :unprocessable_entity
      end
    else
      Rails.logger.warn "User not signed in for theme toggle"
      head :unauthorized
    end
  end
end
