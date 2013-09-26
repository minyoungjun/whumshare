class Chat < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :product
	has_many :messages
end
