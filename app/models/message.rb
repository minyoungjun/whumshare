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
  def self.pf(from_id, chat_id, message)
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

		client.add_message_callback do |m|
			puts "mtype:#{m.type} m#{m}"
			#mtype:chat m<message from='-100001416468070@chat.facebook.com' to='-100002734181687@chat.facebook.com/L436Adsk' type='chat' xmlns='jabber:client'><composing xmlns='http://jabber.org/protocol/chatstates'/></message> 작성중
			#mtype:chat m<message from='-100001416468070@chat.facebook.com' to='-100002734181687@chat.facebook.com/L436Adsk' type='chat' xmlns='jabber:client'><body>ㅁㅁㅁ </body><active xmlns='http://jabber.org/protocol/chatstates'/></message>메세지 받기
      if m.type != :error
        puts m.body
      end
    end

=begin
		begin
			myThread = Thread.current
			mlid = client.add_message_listener do |message|
				message.reply.set_body("Echo: #{message.body}").send
				puts "hoi!!#{message.body}"
				myThread.wakeup if message.body=="shutdown"
			end
			Thread.stop
		  client.delete_message_listener(mlid)
			rescue Exception=>error
				puts error
			#ensure
			#	client.release if client
		end
=end
		#client.close
		

	end

	
end
