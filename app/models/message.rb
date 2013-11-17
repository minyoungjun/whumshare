#encoding:utf-8
#require 'eventmachine'
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
		#FBReceiveMsg.perform_async(@myuser.id, @myuser.uid, @myuser.oauth_token)
		Message.perform(@myuser.id, @myuser.uid, @myuser.oauth_token)
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
  def self.perform(to_id, to_uid, to_oauth_token)
		id = "-#{to_uid}@chat.facebook.com"
		client = Jabber::Client.new Jabber::JID.new(id)
		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, APP_ID, to_oauth_token, APP_SECRET), nil)

		client.add_message_callback do |m|
			puts "!!!"
			puts "m#{m}"
			puts "m_i #{m.inspect}"
			to_user = User.find(to_id)
			if to_user.now_login == false
				break
			end
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

					#faye
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
				else
					puts "uid that no in User.find_by_uid"
				end
			end
			puts "!!!receive doing"
		end
		puts "!!!receive end"
	end
end
