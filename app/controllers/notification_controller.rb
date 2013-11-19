class NotificationController < ApplicationController
  def all_noti
  end

  def message_noti
  end

  def activity_noti
  end

  def post_noti
  end

  def noti_count
		session[:noti_count] = session[:noti_count] + 1

		data = {
			:noti_count => session[:noti_count]
		}
		respond_to do |format|
      format.json { render :json => data.to_json }
    end 
  end
	def push_noti
		puts "push_noti controller"
		Notification.create_push_noti session[:user_id], 1, "hi"
		respond_to do |format|
      format.json { render :json => {} }
    end 
	end



end
