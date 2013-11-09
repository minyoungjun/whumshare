class ChatController < ApplicationController
=begin
	before_filter :params_null_check, :only => [:seller, :buyer]

	def params_null_check
		if params[:id].nil? and params[:product_id].nil?
			redirect_to '/chat/chat_main'
		elsif params[:action] == "seller" and params[:id].nil?
			redirect_to '/chat/chat_main'
		end
	end
=end

	def chatroom 	
	chat_id=params[:id]

		if chat_id.nil?#현 사용자가 구매자일 경우, 채팅 방이 없을 수 있다.

			product_id=params[:product_id]
			product=Product.find(product_id)
			seller_id=product.user_id
			buyer_id=session[:user_id]

			chat=Chat.find_or_make(seller_id,buyer_id,product_id)
		else
			chat=Chat.find(chat_id)
		end

		@user_id=session[:user_id]
		@user_name=User.find(session[:user_id]).name
		@chat_id=chat.id

		@product=chat.product
		@seller=User.find(chat.seller_id)
		@buyer=User.find(chat.buyer_id)

		messages = chat.messages
		messages_with_user = Array.new
		messages.each do |message|
			messages_with_user << [message, message.user.name]
		end
		@messages_with_user = messages_with_user
	end

	def chat_main
	end

	def chat_list
		user_id = session[:user_id]
		chats = Chat.where("seller_id = ? OR buyer_id = ? ", user_id, user_id)

		data = {
			chats: chats,
			user_id: user_id
		}
		
		respond_to do |format|
      format.json { render :json=> data } 
    end
	end
	def send_facebook_message
		Message.send_facebook_message(params[:chat_id], params[:message])

    respond_to do |format|
      format.json { render :json => "success" }
    end
	end

end
