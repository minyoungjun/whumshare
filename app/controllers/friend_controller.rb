class FriendController < ApplicationController
  def friend_product
  end
	def friends_list
		sell_friends_list,join_friends_list,unjoin_friends_list=User.find(session[:user_id]).get_friends_list

		data = {
			:sell_friends_list => sell_friends_list,
			:join_friends_list => join_friends_list,
			:unjoin_friends_list => unjoin_friends_list
		}
		respond_to do |format|
			format.json { render :json => data.to_json }
		end
	end
end
