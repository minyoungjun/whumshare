class FBMsgWorker
  include Sidekiq::Worker

  def perform(from_id, chat_id, message)
		chat=Chat.find(chat_id)
		if chat.buyer_id == from_id.to_i
			to_id = chat.seller_id
		elsif chat.seller_id == from_id.to_i
			to_id = chat.buyer_id
		else
			return false
		end
		from_user=User.find(from_id)
		to_user=User.find(to_id)

		puts "#{chat_id} #{from_id} #{to_id}start facebook send!!!!!!!!!!"
		id = "-#{from_user.uid}@chat.facebook.com"
		to = "-#{to_user.uid}@chat.facebook.com"
		body = message
		subject = "hey"
		send_message = Jabber::Message.new to, body

		client = Jabber::Client.new Jabber::JID.new(id)

		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, '562260310492321', from_user.oauth_token, '9b209a9e006a2244f69419ee5a2b2355'), nil)

		client.send send_message
		client.close
	end
end
