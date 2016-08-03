Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create, :update]
  patch '/cat_rental_requests/approve/:id' => 'cat_rental_requests#approve', :as => "approve"
  patch '/cat_rental_requests/deny/:id' => 'cat_rental_requests#deny', :as => "deny"
end
