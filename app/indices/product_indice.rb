#ThinkingSphinx::Index.define :product, :with => :active_record do
ThinkingSphinx::Index.define :product, :with => :real_time do

	indexes name
	indexes place
	indexes comment

	has user_id,			:type =>:integer 
	has category_id,	:type =>:integer
	has created_at,  	:type =>:timestamp
end
