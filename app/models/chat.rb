class Chat < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :product
	has_many :messages
	
	def self.find_or_make(seller_id, buyer_id, product_id)
		chat = self.where(:seller_id => seller_id, :buyer_id=>buyer_id, :product_id => product_id).first

		if chat.nil?
			chat=self.new
			chat.product_id=product_id
			chat.seller_id=seller_id
			chat.buyer_id=buyer_id
			chat.save
		end

		chat
	end
	
	def self.sync_message(user_id)
		chats = Chat.search_by_user_id(user_id)
		prev_created_time = "9999999999"
		chats.each do |chat|
			last_message = chat.messages.last #whum에서 한 마지막 메세지 
			unixtime_last_message = last_message.created_at.to_time.to_i
			last_message_uid = last_message.user.uid

			run_loop = true
			0.upto(5)  do
				fb_messages = FbGraph::Query.new("SELECT author_id, viewer_id, body, message_id, created_time FROM message WHERE thread_id = #{chat.room_number} AND created_time < #{prev_created_time}").fetch(:access_token => User.find(user_id).oauth_token)
				
				users = Array.new
				user = Hash.new
				user[:id] = chat.seller_id
				user[:uid] = User.find(user[:id]).uid
				users << user

				user = Hash.new
				user[:id] = chat.buyer_id
				user[:uid] = User.find(user[:id]).uid
				users << user

				get_fb_messages = Array.new

				fb_messages.reverse.each do |fb_message|
					puts "!!!#{fb_message.inspect}"

					puts "time_stamp created_time#{fb_message["created_time"].to_i} unixtime_list_message #{unixtime_last_message}"
					if(fb_message["created_time"].to_i - unixtime_last_message < 60) #차이가 60초 이상인 것은 체크 하지 않는다. 무결성이 유지되었을 때 이것이 가능

						puts "hoi_time_stamp created_time#{fb_message["created_time"].to_i} unixtime_list_message #{unixtime_last_message}"
						puts "fb_message[author_id] #{fb_message["author_id"]} #{last_message_uid} #{fb_message["body"]} #{last_message.content}"
						if(fb_message["author_id"].to_s == last_message_uid and fb_message["body"] == last_message.content)
							run_loop = false
							get_fb_messages.reverse.each do |fb_msg|
								m = chat.messages.new
								if(fb_msg["author_id"].to_s == users[0][:uid] )
									m.user_id = users[0][:id]
								elsif(fb_msg["author_id"].to_s == users[1][:uid] )
									m.user_id = users[1][:id]
								end
								m.content = fb_msg["body"]
								m.save
							end
							break
						end
					end
					prev_created_time = fb_message["created_time"]

					get_fb_messages << fb_message

					if(run_loop == false)
						break
					end

				end
			end
		end
	end

	def self.search_by_user_id(user_id)
		chat1 = Chat.where("buyer_id = #{user_id}")
		chat2 = Chat.where("seller_id = #{user_id}")
		chats = chat1 + chat2
		chats.uniq!

		chats
	end
end
