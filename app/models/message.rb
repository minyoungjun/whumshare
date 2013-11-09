#encoding=utf-8
class Message < ActiveRecord::Base
	attr_accessor :myuser

	APP_ID = '562260310492321'
	APP_SECRET = '9b209a9e006a2244f69419ee5a2b2355'

	belongs_to :chat
	belongs_to :user

	def self.connect_facebook_chat(user)
		@myuser = user
		id = "-#{user.uid}@chat.facebook.com"
		client = Jabber::Client.new Jabber::JID.new(id)
		FBReceiveMsg.perform_async(@myuser.id, @myuser.uid, @myuser.oauth_token)
	end

	def self.send_facebook_message(chat_id, message)
		#make message

		puts "connect_facebook_c!! #{@myuser.inspect}"
		if @myuser.nil?
			puts "no @myuser"
			return false
		end

		msg=self.new
		msg.chat_id = chat_id
		msg.user_id = @myuser.id
		msg.content = message
		msg.save

		chat=Chat.find(chat_id)

		if chat.buyer_id == @myuser.id
			to_id = chat.seller_id
		elsif chat.seller_id == @myuser.id
			to_id = chat.buyer_id
		else
			puts "ERROR! can't match chat_id! user_id=#{@myuser.id} chat=#{chat.inspect}"
		end
		to_uid = User.find(to_id).uid

		puts "@to_id/messge #{to_id} #{message}"
		FBMsgWorker.perform_async(@myuser.uid, to_uid, message, @myuser.oauth_token, false, chat_id)
	end


	def self.send_first_facebook_message(chat_id)
		puts "connect_facebook_c!! #{@myuser.inspect}"
		if @myuser.nil?
			puts "no @myuser"
			return false
		end


		chat=Chat.find(chat_id)
		if chat.buyer_id == @myuser.id
			to_id = chat.seller_id
		elsif chat.seller_id == @myuser.id
			to_id = chat.buyer_id
		else
			puts "ERROR! can't match chat_id! user_id=#{@myuser.id} chat=#{chat.inspect}"
		end

		message="WHUM 알림 : #{@myuser.name}님께서 #{chat.product.name}에 대해 대화를 신청하였습니다."
		to_uid = User.find(to_id).uid

		msg=self.new
		msg.chat_id = chat_id
		msg.user_id = @myuser.id
		msg.content = message
		msg.save
		
		puts "@to_id/messge #{to_id} #{message}"
		FBMsgWorker.perform_async(@myuser.uid, to_uid, message, @myuser.oauth_token, true, chat_id)
	end

end
