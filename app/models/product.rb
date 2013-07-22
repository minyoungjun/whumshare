class Product < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to	:user
	belongs_to	:category
	has_many	:buskets
end
