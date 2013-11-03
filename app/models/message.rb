class Message < ActiveRecord::Base
	attr_accessor :facebook_client,:myuser

	APP_ID = '562260310492321'
	APP_SECRET = '9b209a9e006a2244f69419ee5a2b2355'

	belongs_to :chat
	belongs_to :user

	def self.connect_facebook_chat(user)
		@myuser = user
		puts "connect_facebook_c #{@myuser.inspect}"
		uid = "-#{@myuser.uid}@chat.facebook.com"
		client = Jabber::Client.new Jabber::JID.new(uid)
		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, APP_ID, user.oauth_token, APP_SECRET), nil)
		@facebook_client = client
	end

	def self.disconnect_facebook_chat
		@facebook_client.close unless @facebook_client.nil?
		@facebook_client = nil
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

		#FBSendMsgWorker.perform_async(@facebook_client, to_id, message)
		facebook_client=@facebook_client
		puts "@facebook #{facebook_client.to_s}"
		puts "@to_id/messge #{to_id} #{message}"
		FBMsgWorker.perform_async(@myuser.uid, to_uid, message, @myuser.oauth_token)
	end
end
