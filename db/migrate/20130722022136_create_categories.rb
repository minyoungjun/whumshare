class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
			t.string	:uplevel_id, :default=>1
			t.string	:name, :null=>false
			t.integer	:count, :default=>0
      t.timestamps
    end
  end
end
