FacebookSend::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
	match 'send', to:'facebook#send_message'
	match 'post', to:'facebook#post_feed'
  root to: 'facebook#index'
end
