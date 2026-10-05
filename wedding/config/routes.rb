Rails.application.routes.draw do
  # Static pages
  root "pages#home"
  get "info",   to: "pages#info",   as: :info
  get "travel", to: "pages#travel", as: :travel

  # Admin area (HTTP Basic Auth)
  namespace :admin do
    root "dashboard#show", as: :root
    resources :page_sections, path: "sections"
    resources :page_images,    path: "images"
  end

  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check
end
