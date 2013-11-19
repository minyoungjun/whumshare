class ApplicationController < ActionController::Base
  protect_from_forgery
	before_filter :category_session, :set_user_session
	def category_session
		if(session[:category_id].nil?)
			session[:category_id]=1
		end
	end
	def set_user_session
		if(session[:user_id].nil?)
			@user_id = 0
		else
			@user_id = session[:user_id]
		end
		
	end
	#TODO this action is for push noti test

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
	def categories
    @categories = Category.all 
  end

	def uplevel_category
		puts "?!?!#{session[:category_id]}"
		uplevel_category=Array.new
		if session[:category_id].nil? || session[:category_id]==0
			uplevel_category.push(0)
		else
			uplevel_category=Category.find(session[:category_id]).uplevel
		end
		puts "?!?!#{uplevel_category}"
		@uplevel_category=uplevel_category
	end	
	def current_category
		if session[:category_id].nil? || session[:category_id]==0
			@current_category=Category.find(1)
		else
			@current_category=Category.find(session[:category_id])
		end

	end
  helper_method :current_user, :categories, :uplevel_category, :current_category
end
