class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
			t.integer	:user_id
			t.string	:name
			t.integer	:price
			t.integer	:method
			t.string	:place
			t.integer :category_id
			t.integer	:buy_year
			t.integer	:buy_month
			t.text		:comment
			t.boolean	:on_timeline
			t.integer :status

      t.timestamps
    end
  end
end
