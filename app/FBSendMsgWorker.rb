class FBSendMsgWorker
  include Sidekiq::Worker

  def perform(client, to_id, message)
=begin
		to_uid=User.find(to_id).uid

		to = "-#{to_uid}@chat.facebook.com"
		body = message
		send_message = Jabber::Message.new to, body

		client.send send_message
		client.close
=end
	end
end
