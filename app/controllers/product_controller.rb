class ProductController < ApplicationController
  def seller_info
		user=User.find(session[:user_id])
		@friend_count=user.friend_count
		@gender=Option.get_name("gender",user.gender)
		@sell_products=Product.with_option_name(user.products)

		puts "!!!!!!#{@statuses}!!!!!!!!"
  end
  def sell_product
		@categories=Category.all
		puts @categories
		if !session[:category_id].nil?
			@current_category=Category.find(session[:category_id])
		else
			@current_category=Category.find(1)
		end
		puts "current!!!#{@current_category}"

		@methods=Option.where(:type_name=>"method").all
  end
  def sell_product_json
		product_id=Product.add(params,session)

		data = { 
      :error_code => 0,
      :error_msg => "",
			:product_id => product_id
    }   

    respond_to do |format|
      format.json { render :json => data.to_json }
    end 
	end

  def product_list
	end
	def get_product_list
		category_id=params[:category_id]
		downlevel_categories=Category.find(category_id).downlevel([])	
		products=Product.find_all_by_category_id(downlevel_categories)
		users=Product.get_users(products)
		uploads=Product.get_represent_upload_url(products)
		method=Option.where(:type_name=>"method").all
		status=Option.where(:type_name=>"status").all
		gender=Option.where(:type_name=>"gender").all

		data={
			products: products,
			users: users,
			uploads: uploads,
			method:method,
			status:status,
			gender:gender
		}
		respond_to do |format|
      format.json { render :json => data.to_json }
    end
	end
	def product_modal_json
		product=Product.find(params[:product_id])
		uploads=Upload.get_files_url(product.uploads)
		method=Option.get_name("method",product.method)
		status=Option.get_name("status",product.status)
		puts "method:#{method}" 

		data = { 
      :error_code => 0,
      :error_msg => "",
			:product=>product,
			:uploads=>uploads,
			:method=>method,
			:status=>status
    }   

    respond_to do |format|
      format.json { render :json => data.to_json }
    end 

	end
	def category
		categories=Category.all		
		data={
			category: categories
		}
		respond_to do |format|
      format.json { render :json => data.to_json }
    end 
	end

	def my_search

	end
	def sell_represent_upload_json
		product_id=params[:product_id]
		product=Product.find(product_id)
		product.represent_upload_id=params[:upload_id];
		product.save

		data={
		}
		respond_to do |format|
      format.json { render :json => data.to_json }
    end 
	end
end
