class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
		user.now_login = true
		user.save!

		Message.connect_facebook_chat user

    session[:user_id] = user.id
		session[:category_id]=1 if session[:category_id].nil?

		puts "category_id!!:#{session[:category_id]}";
    redirect_to root_url
  end

  def destroy
		#have to check user is online or not. if user do nothing over 15 min, logout.

		user = User.find(session[:user_id])
		user.now_login = false
		user.save!

    session[:user_id] = nil
    redirect_to root_url
  end

  def category
    session[:category_id]=params[:category_id].to_i
    data = { 
    }   

    respond_to do |format|
      format.json { render :json => data.to_json }
    end 
  end

end
