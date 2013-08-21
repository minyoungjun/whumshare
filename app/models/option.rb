class Option < ActiveRecord::Base
  attr_accessible :type_name, :code,:name

	def self.get_name(type_name,code)
		method=Option.where("type_name= ? AND code= ?",type_name,code).first.name
		return method
	end

end
