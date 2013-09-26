#ThinkingSphinx::Index.define :product, :with => :active_record do
ThinkingSphinx::Index.define :product, :with => :real_time do
	indexes name
	indexes place
	indexes comment

	has user_id,			:type =>:integer 
	has category_id,	:type =>:integer
	has created_at,  	:type =>:timestamp
	set_property :dict => 'keywords'
	set_property :enable_star => 1
	set_property :min_infix_len => 1
end
=begin
ThinkingSphinx::Index.define :product, :with => :active_record do
#ThinkingSphinx::Index.define :product, :with => :real_time do
	indexes name
	indexes place
	indexes comment

	has user_id,			:type =>:integer 
	has category_id,	:type =>:integer
	has created_at,  	:type =>:timestamp

end

=end
