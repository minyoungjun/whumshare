class FBDisconnect
  include Sidekiq::Worker

	APP_ID = '562260310492321'
	APP_SECRET = '9b209a9e006a2244f69419ee5a2b2355'

  def perform(from_uid, from_oauth_token)
			id = "-#{from_uid}@chat.facebook.com"
			client = Jabber::Client.new Jabber::JID.new(id)
			client.connect
			client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, APP_ID, from_oauth_token, APP_SECRET), nil)
			client.close
	end
end
