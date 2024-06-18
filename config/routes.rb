Rails.application.routes.draw do
  root "students#index"

  get 'users/dashboard', to: 'admins#dashboard'
  get 'users/students/new', to: 'admins#new_student'
  post 'users/students', to: 'admins#create_student'

  get 'admins/login', to: 'admins#login'
  post 'admins/authenticate', to: 'admins#authenticate'
  get 'admins/logout', to: 'admins#logout'
  get 'admins/dashboard', to: 'admins#dashboard' 
  get 'admins/time_in_history', to: 'admins#time_in_history'
  get 'admins/time_out_history', to: 'admins#time_out_history'
  get 'admins/all_students', to: 'admins#all_students'
  get 'admins/delete_student/:id', to: 'admins#delete_student', as: 'delete_student'

  get 'admins/edit/:id', to: 'admins#edit', as: 'edit_student'
  post 'admins/update/:id', to: 'admins#update'
  
  get 'students/index', to: 'students#index'
  get 'students/time_in', to: 'students#time_in_form'
  post 'students/time_in', to: 'students#time_in'
  get 'students/time_out', to: 'students#time_out_form'
  post 'students/time_out', to: 'students#time_out'

  post 'attendances/time_in', to: 'attendances#time_in'
  post 'attendances/time_out', to: 'attendances#time_out'

  resources :admins, only: [:edit, :update] 

end
