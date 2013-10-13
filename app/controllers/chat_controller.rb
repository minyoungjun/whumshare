class ChatController < ApplicationController
	def index
		product_id=params[:product_id]
		product=Product.find(product_id)
		seller_id=product.user_id
		buyer_id=session[:user_id]

		chat=Chat.find_or_make(seller_id,buyer_id,product_id)

		@user_id=session[:user_id]
		@chat_id=chat.id

		@product=product
		@seller=User.find(chat.seller_id)
		@buyer=User.find(chat.buyer_id)

    @chat_messages = chat.messages
	end
end
