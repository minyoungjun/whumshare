class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
		user.now_login = true

		Message.connect_facebook_chat user

    session[:user_id] = user.id
		session[:category_id]=1 if session[:category_id].nil?

		puts "category_id!!:#{session[:category_id]}";
    redirect_to root_url
  end

  def destroy
		#have to check user is online or not. if user do nothing over 15 min, logout.

		user.now_login = false

		Message.disconnect_facebook_chat

    session[:user_id] = nil
    redirect_to root_url
  end

  def category
    session[:category_id]=params[:category_id].to_i
    data = { 
      :error_code => 0,
      :error_msg => "",
    }   

    respond_to do |format|
      format.json { render :json => data.to_json }
    end 
  end

end
