class Busket < ActiveRecord::Base
  # attr_accessible :title, :body
	belong_to	:user
	belong_to	:product
end
