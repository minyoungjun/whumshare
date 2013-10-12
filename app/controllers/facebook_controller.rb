# encoding: utf-8
class FacebookController < ApplicationController
	require 'xmpp4r_facebook'

  def index
	if current_user
			puts User.find(session[:user_id]).oauth_token
			
			redirect_to "/product/product_list"
		end
  end
  def function
		if current_user
			puts User.find(session[:user_id]).oauth_token
		end
  end

	def self.send_message(message_id,message)
		to_id=params[:message_id]
		id = "-#{User.find(session[:user_id]).uid}@chat.facebook.com"
		to = "-#{to_id}@chat.facebook.com"
		body = params[:message]
		subject = 'message from ruby'
		message = Jabber::Message.new to, body
		message.subject = subject

		client = Jabber::Client.new Jabber::JID.new(id)
		client.connect
		client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, '562260310492321', User.find(session[:user_id]).oauth_token, '9b209a9e006a2244f69419ee5a2b2355'), nil)

		client.send message
		client.close

    data = { 
			:msg=>"success!"
    }   
    respond_to do |format|
      format.json { render :json => data.to_json }
    end 

	end
	def post_feed
	    fb_user = FbGraph::User.me(User.find(session[:user_id]).oauth_token)
	    fb_friend = fb_user.friends
			#puts "friend!!!#{fb_friend.inspect}"

			fb_user.feed!(:message => params[:message])

			data = { 
				:msg=>"success!"
			}   
			respond_to do |format|
				format.json { render :json => data.to_json }
			end 
	end
	
	def receive_message
	end

end
