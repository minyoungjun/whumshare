class CreateMySearches < ActiveRecord::Migration
  def change
    create_table :my_searches do |t|
			t.integer	:user_id
			t.integer	:category_id
			t.string	:place
			t.string	:name
			t.integer	:method
			t.integer	:min_price
			t.integer	:max_price
			t.integer	:buy_min_year
			t.integer	:buy_max_year

      t.timestamps
    end
  end
end
