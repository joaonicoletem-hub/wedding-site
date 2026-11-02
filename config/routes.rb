Rails.application.routes.draw do
  # Static pages
  root "pages#home"
  get "info", to: "pages#info", as: :info

  # RSVP
  get "rsvp", to: "rsvps#new", as: :rsvp
  post "rsvp", to: "rsvps#create"

  namespace :admin do
    resources :rsvps, only: :index do
      collection do
        get :export
      end
    end
  end

  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check
end
