class Product < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to	:user
	belongs_to	:category
	has_many	:buskets
	has_many	:uploads
	def self.add(params,session)
		puts "params! :#{params.inspect}"
		product=Product.new
		product.user_id=session[:user_id]
		product.name= params[:name]	
		product.price= params[:price].to_i
		product.method= params[:method].to_i
		product.place= params[:place]	
		product.category_id= params[:category_id].to_i
		product.buy_year= params[:year].to_i
		product.buy_month= params[:month].to_i
		product.comment= params[:comment]
		if params[:timeline_check]=="true"
			product.on_timeline= true
		else
			product.on_timeline= false
		end
		product.status=0	
		product.save
		return product.id
	end
	def self.get_users products
		users=Array.new
		products.each do |product|
			users.push(product.user)
		end
		return users
	end
	def self.get_represent_upload_url products
		uploads=Array.new
		products.each do |product|
			represent_upload_id=product.represent_upload_id
			#이미지를 등록하지 않았을 경우
			if(represent_upload_id==0)
				uploads.push("/noimage.png");
			else
				upload=Upload.find(represent_upload_id)
				uploads.push(upload.get_file_url);
			end
		end
		return uploads
	end
	def self.with_option_name products
		products_with_option_name=Array.new
		products.each do |product|
			pwu=Hash.new
			pwu[:product]=product
			pwu[:method]=Option.get_name("method",product.method)
			pwu[:status]=Option.get_name("status",product.status)
			pwu[:category]=product.category.name
			products_with_option_name.push(pwu)
		end
		return products_with_option_name
	end

	def self.search_products(condition, categories_id)
		puts "!@#!@#"
		puts categories_id.inspect
		with=Hash.new
		with[:category_id]=categories_id
		per_page=12
    products=Product.search(
    :conditions=>{
				:name=>"*aaa*"
				#:name=>"*#{condition[:name]}*",
				#:place=>"*#{condition[:place]}*",
				#:comment=>"*#{condition[:comment]}*",
      },
      :order=>'created_at DESC',
			:with => with,
			:page => condition[:page],
			:per_page => per_page
      )

    return products
  end
end
