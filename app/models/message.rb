class Message < ActiveRecord::Base
	attr_accessor :myuser
	@@facebook_client = nil

	APP_ID = '562260310492321'
	APP_SECRET = '9b209a9e006a2244f69419ee5a2b2355'

	belongs_to :chat
	belongs_to :user

	def self.connect_facebook_chat(user)
		@myuser = user
		id = "-#{user.uid}@chat.facebook.com"
		client = Jabber::Client.new Jabber::JID.new(id)
		$facebook_client = client
		puts "facebook_client #{$facebook_client}"
		puts "facebook_client #{$facebook_client.inspect}"

		FBReceiveMsg.perform_async(@myuser.id, @myuser.uid, @myuser.oauth_token)
	end

	def self.disconnect_facebook_chat

		FBDisconnect.perform_async(@myuser.uid, @myuser.oauth_token) unless @myuser.nil?
	end
	def self.get_facebook_client
		@@facebook_client
	end

	def self.send_facebook_message(chat_id, message)
	#make message

		puts "connect_facebook_c!! #{@myuser.inspect}"
		if @myuser.nil?
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
		FBMsgWorker.perform_async(@myuser.uid, to_uid, message, @myuser.oauth_token)
	end
end
