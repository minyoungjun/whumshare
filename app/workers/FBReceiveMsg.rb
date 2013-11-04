class FBReceiveMsg
  include Sidekiq::Worker

	APP_ID = '562260310492321'
	APP_SECRET = '9b209a9e006a2244f69419ee5a2b2355'

  def perform(from_id, from_uid, from_oauth_token)
		id = "-#{from_uid}@chat.facebook.com"
		client = Jabber::Client.new Jabber::JID.new(id)
		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, APP_ID, from_oauth_token, APP_SECRET), nil)

		client.add_message_callback do |m|
			if User.find(from_id).now_login == false
				break
			end

			puts "mtype:#{m.type} m#{m}"

			#mtype:chat m<message from='-100001416468070@chat.facebook.com' to='-100002734181687@chat.facebook.com/L436Adsk' type='chat' xmlns='jabber:client'><composing xmlns='http://jabber.org/protocol/chatstates'/></message> 작성중
			#mtype:chat m<message from='-100001416468070@chat.facebook.com' to='-100002734181687@chat.facebook.com/L436Adsk' type='chat' xmlns='jabber:client'><body>ㅁㅁㅁ </body><active xmlns='http://jabber.org/protocol/chatstates'/></message>메세지 받기
			if m.type != :error
				puts "Message : #{m.body}"
			end
		end
	end
=begin
private
	def is_composing(message)
		puts "message"
		s = message.index('<',1)
		e = message.index('/>')
		str = message[s..e+1]
		puts "STR#{str}"
		
		if str == "<composing xmlns='http://jabber.org/protocol/chatstates'/>"
			ret = true
		else
			ret = false
		end

		ret
	end
=end
end
