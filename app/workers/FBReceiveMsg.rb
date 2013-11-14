#encoding:utf-8
require 'eventmachine'

class FBReceiveMsg
  include Sidekiq::Worker

	APP_ID = '562260310492321'
	APP_SECRET = '9b209a9e006a2244f69419ee5a2b2355'

  def perform(to_id, to_uid, to_oauth_token)
		id = "-#{to_uid}@chat.facebook.com"
		client = Jabber::Client.new Jabber::JID.new(id)
		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, APP_ID, to_oauth_token, APP_SECRET), nil)

		client.add_message_callback do |m|
			to_user = User.find(to_id)
			if to_user.now_login == false
				break
			end

			puts "mtype:#{m.type} m#{m}"

			if m.type != :error and !(m.body.nil?)
				puts "from : #{m.from}"
				puts "Message : #{m.body}"
				from_uid = m.from.node[1..-1]
				puts "#{m.from} from_uid#{from_uid}"
				from_user = User.find_by_uid(from_uid)
				puts "from_user#{from_user.inspect}"
				
				if from_user.nil? == false
					puts "receive message => chat from_user_id#{from_user.id} to_user#{to_user.id}"
					#get chat that contain from_user, to_user
					chats = Chat.where("seller_id = ? AND buyer_id = ?", from_user.id, to_user.id) + Chat.where("seller_id = ? AND buyer_id = ?", to_user.id, from_user.id)
					chats.uniq!
					puts "chat #{chats.inspect}"

					#EM.run {
						client = Faye::Client.new('http://share.whum.net/faye')
						chats.each do |chat|
							msg = chat.messages.new
							msg.user_id = from_user.id
							msg.content = m.body
							msg.save!

							data = {
								:message => m.body,
								:chat_id => chat.id,
								:user_id => from_user.id,
								:user_name => from_user.name,
								:created_at => Time.now
							}
							client.publish("/chat/#{chat.id}", data)
						end
					#}
				else
					puts "uid that no in User.find_by_uid"
				end
			end
			puts "!!!receive doing"
		end
		puts "!!!receive end"
	end
end
