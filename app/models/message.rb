class Message < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :chat
	belongs_to :user

	def self.make_msg(chat_id, user_id, message)
		msg=self.new
		msg.chat_id = chat_id
		msg.user_id = user_id
		msg.content = message
		msg.save
		puts "#{chat_id} #{user_id} #{message}!!!!!!!!!!!!!!!!!"

		#FBMsgWorker.perform_async(user_id, chat_id, message)
		self.pf(user_id, chat_id, message)
	end
private
	def self.pf(from_id,chat_id, message)
		chat=Chat.find(chat_id)
		puts "qqqqqqqqqqqqq"
		if chat.buyer_id == from_id.to_i
			to_id = chat.seller_id
		elsif chat.seller_id == from_id.to_i
			to_id = chat.buyer_id
		else
			return false
		end

		puts "#{chat_id} #{from_id} #{to_id}start facebook send!!!!!!!!!!"
		id = "-#{User.find(from_id).uid}@chat.facebook.com"
		to = "-#{User.find(to_id).uid}@chat.facebook.com"
		body = message
		message = Jabber::Message.new to, body

		client = Jabber::Client.new Jabber::JID.new(id)
		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, '562260310492321', User.find(from_id).oauth_token, '9b209a9e006a2244f69419ee5a2b2355'), nil)

		client.send message
		client.close
  end

end
