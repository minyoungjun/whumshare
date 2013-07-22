class MySearch < ActiveRecord::Base
  # attr_accessible :title, :body
	belong_to	:user
	belong_to	:category
end
