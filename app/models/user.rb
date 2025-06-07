class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Nowa składnia Rails 8
  enum :role, [ :user, :admin, :super_admin ], default: :user
  enum :theme, [ :light, :dark, :auto ], default: :light

  # Validations
  validates :first_name, presence: true, allow_blank: true
  validates :last_name, presence: true, allow_blank: true

  # Methods
  def full_name
    return email if first_name.blank? && last_name.blank?
    "#{first_name} #{last_name}".strip
  end

  def display_name
    full_name.present? ? full_name : email.split("@").first
  end

  def admin_access?
    admin? || super_admin?
  end

  def dark?
    theme == "dark"
  end
end
