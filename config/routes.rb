Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/new'
  get 'tasks/edit'
  get 'tasks/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
