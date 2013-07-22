class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
			t.string	:type_name
			t.integer	:code
			t.string	:name

      t.timestamps
    end
  end
end
