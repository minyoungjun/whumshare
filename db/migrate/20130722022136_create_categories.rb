class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
			t.string	:uplevel_id, :default=>0
			t.string	:uplevel_list	
			t.string	:name
			t.integer	:count
      t.timestamps
    end
  end
end
