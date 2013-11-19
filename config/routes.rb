FacebookSend::Application.routes.draw do

	resources :uploads 

  root to: 'product#product_list'
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
	match 'send', to:'facebook#send_message'
	match 'post', to:'facebook#post_feed'
	match 'function', to:'facebook#function'

  match ':controller(/:action(/:id))(.:format)'

  faye_server '/faye', timeout: 25 do
    map '/chat/*' => RealtimeChatController
    map '/noti_push/*' => RealtimeChatController
    map default: :block
  end

  resources :chat
  resources :noti_push
	match 'chat', to:'chat#index'
	match 'chat_main', to:'chat#index'
end
