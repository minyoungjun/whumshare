class User < ActiveRecord::Base

  # attr_accessible :title, :body
	has_many	:products
	has_many	:buskets
	has_many	:evaluations
	has_many	:my_searches

  def self.from_omniauth(auth)
		puts "!!!!#{auth}"
=begin

		client = FBGraph::Client.new(:client_id => '562260310492321', :secret_id => '9b209a9e006a2244f69419ee5a2b2355', :token => auth.credentials.token)
    #client.inspect
		u = client.selection.me.info!
		#temp=client.selection.me.home.info! 
    #puts "fbgraph!!: #{temp}"
    client.selection.user(u[:id]).feed.publish!(:message => 'test message', :name => 'test name')
    render :json => client.selection.me.info!  

		client = FBGraph::Client.new(:client_id => '562260310492321', :secret_id => '9b209a9e006a2244f69419ee5a2b2355', :token => auth.credentials.token)
		u = client.selection.me.friends.info!
		user_friend_count=u.data.data.size

		puts "user_friend_count:#{u.data.data.size}"
		
		u = client.selection.me.info!

		puts "birthday:::#{u.inspect}"
=end
	
		
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
			user.thumb_img = auth.info.image
			#user.friend_count=user_friend_count
			case auth.extra.raw_info.gender
			when "female"
				user.gender=0
			when "male"
				user.gender=1
			else
				user.gender=2
			end

      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
	def get_friends_list
		fb_user = FbGraph::User.me(self.oauth_token)
	  fb_friends = fb_user.friends

		sell_friends_list=Array.new
		join_friends_list=Array.new
		unjoin_friends_list=Array.new

		fb_friends.each do |friend|
			friend_info=Hash.new
			friend_info[:name]=friend.name
			friend_info[:id]=friend.raw_attributes[:id]
			user=User.find_by_uid(friend_info[:id])
			if user.nil?
				unjoin_friends_list.push(friend_info)
			else
				if(user.products.count==0)
					join_friends_list.push(friend_info)
				else
					sell_friends_list.push(friend_info)
				end
			end
		end
		return [sell_friends_list,join_friends_list,unjoin_friends_list]
	end
end
