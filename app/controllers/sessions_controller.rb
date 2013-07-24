class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def category
    session[:category_id]=params[:category_id].to_i
		puts "????#{params[:category_id]}"
		puts "????#{session[:category_id]}"
    data = { 
      :error_code => 0,
      :error_msg => "",
    }   

    respond_to do |format|
      format.json { render :json => data.to_json }
    end 
  end

end
