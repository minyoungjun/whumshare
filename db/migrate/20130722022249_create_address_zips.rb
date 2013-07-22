class CreateAddressZips < ActiveRecord::Migration
  def change
    create_table :address_zips do |t|
			t.string	:code
			t.string	:zip

      t.timestamps
    end
  end
end
