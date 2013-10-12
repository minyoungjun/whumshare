// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require moment
//= require faye
//= require jquery_ujs
//= require jquery-fileupload
//= require_tree .

function category_list(id){ 
  $.ajax({
    url: "/sessions/category.json",
    type: "POST",
    data: {
      category_id: id
    }
  });

  $.ajax({
    url: "/product/get_product_list.json",
    type: "POST",
    data: {
      category_id: id
    },
		success: function(data){
			method=data.method;
			mystatus=data.status;
			gender=data.gender;
			product_page=""
			for(i=0;i<data.products.length;i++){
				product=data.products[i];
				user=data.users[i];
				upload=data.uploads[i];
				product_text=make_product_text(product,user,method,mystatus,gender,upload);
				product_page+=product_text
			}

				$("#product_page").html(product_page);
		}
	});
	if($("#toggle_"+id).hasClass("collapsed")==true){
		$("#category_fold_"+id).text("-");
	}
	else{
		$("#category_fold_"+id).text("+");
	}
}

function make_product_text(product,user,method,status,gender,upload){
	product_text="";
	product_text+="<div class='well'>\n"
	product_text+="	<div class='row-fluid'>\n"
	product_text+="		<a class='btn' href='/product/seller_info' >\n"
	product_text+="			<img src='"+user.thumb_img+"' width='30'>"+user.name+"/"+gender[user.gender].name
	product_text+="		</a> \n"
	product_text+="		<div class='row-fluid' onclick='product_modal_button("+product.id+");'>\n"
	product_text+="			<div class='span2'>\n"
	product_text+="				<img src='.." + upload + "'>\n"
	product_text+="			</div>\n"
	product_text+="			<div class='span10'>\n"
	product_text+=				product.name+"/"
	product_text+=				product.price+"/"
	product_text+=				product.buy_year+"년 "+product.buy_month+"월/"
	product_text+=				method[product.method].name+"/"
	product_text+=				status[product.status].name+"/"
	product_text+=				product.comment
	product_text+="			</div>\n"
	product_text+="		</div>\n"
	product_text+="	</div>\n"
	product_text+="</div>\n"

	return product_text
}

