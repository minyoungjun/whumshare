class ProductController < ApplicationController
  def seller_info
  end

  def sell_product
  end

  def product_list
		if session[:category_id].nil?
			@products=Product.all
		else
			@products=Product.where(:category_id=>session[:category_id])
		end
  end
	def my_search
	end
end
