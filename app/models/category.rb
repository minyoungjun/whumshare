class Category < ActiveRecord::Base
   attr_accessible :name,:uplevel_id, :uplevel_list, :count, :end

	 def uplevel
	 	up_list=Array.new
		up_list.push(self.id)
		up_id=self.uplevel_id
		puts self.inspect
	 	while(up_id.to_i!=0)
			up_list.push(up_id.to_i)
			puts "up_list!=#{up_list}"
			up_id=Category.find(up_id).uplevel_id
		end
		return up_list
	end
	def downlevel downlist
		downlist.push(self.id)
		downs=Category.where(:uplevel_id=>self.id)
		downs.each do |down|
			down.downlevel(downlist)
		end
		return downlist
	end
			
end
