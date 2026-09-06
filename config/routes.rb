Rails.application.routes.draw do
  # Static pages
  root "pages#home"
  get "info", to: "pages#info", as: :info

  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check
end
