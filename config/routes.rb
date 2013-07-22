FacebookSend::Application.routes.draw do
  get "notification/all_noti"
  get "notification/message_noti"
  get "notification/activity_noti"
  get "notification/post_noti"

  get "friend/friend_product"
	
  get "product/seller_info"
  get "product/sell_product"
  get "product/product_list"

  get "user/my_search"
  get "user/evaluation"
  get "user/my_info"
  get "user/preference"
  get "user/basket"
  get "user/my_buy_product"
  get "user/my_sell_product"

  get "chat/chat_message"
  get "chat/chat_side"

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
	match 'send', to:'facebook#send_message'
	match 'post', to:'facebook#post_feed'
  root to: 'facebook#index'
end
