ThinkingSphinx::Index.define :product, :with => :active_record do
	indexes name
	indexes place
	indexes comment

	has created_at
	has price
end
