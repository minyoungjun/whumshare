class Chat < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :product
	has_many :messages
	
	def find_or_make(seller_id, buyer_id, product_id)
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
end
