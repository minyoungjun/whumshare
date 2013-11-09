class FBMsgWorker
  include Sidekiq::Worker
	sidekiq_options :retry => false, :backtrace => true

	APP_ID = '562260310492321'
	APP_SECRET = '9b209a9e006a2244f69419ee5a2b2355'

  def perform(from_uid, to_uid, message, from_oauth_token, is_first_message, chat_id) 
		#puts "client #{client}"
		#메세지 보내기 connect가 반복된다
		puts "from_uid #{from_uid}"
		puts "to_uid #{to_uid}"
		puts "message #{message}"

		id = "-#{from_uid}@chat.facebook.com"
		to = "-#{to_uid}@chat.facebook.com"

		body = message
		send_message = Jabber::Message.new to, body

		client = Jabber::Client.new Jabber::JID.new(id)

		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, APP_ID, from_oauth_token, APP_SECRET), nil)

		client.send send_message
		client.close
		
		if(is_first_message)
			inboxes = FbGraph::Query.new("SELECT author_id, viewer_id, thread_id, body FROM message WHERE thread_id IN (SELECT thread_id FROM thread WHERE folder_id=0 OR folder_id=1)").fetch(:access_token => from_oauth_token)
			puts "FB #{inboxes.inspect}"
			inboxes.each do |inbox|
				puts "FBinbox #{inbox.inspect}"
				if(inbox["author_id"] == from_uid and inbox["body"] == message) 
						puts "OK"
					
						chat = Chat.find(chat_id)
						chat.room_number = inbox["thread_id"]
						chat.save
						break
				end
			end
		end
	end
end
