FacebookSend::Application.routes.draw do
  get "product/seller_info"

  get "product/sell_product"

  get "product/product_list"

  get "user/my_search"

  get "user/evaluation"

  get "user/my_info"

  get "user/preference"

  get "chat/chat_message"

  get "chat/chat_side"

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
	match 'send', to:'facebook#send_message'
	match 'post', to:'facebook#post_feed'
  root to: 'facebook#index'
end
