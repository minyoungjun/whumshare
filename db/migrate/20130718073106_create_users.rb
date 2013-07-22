class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
			t.integer	:age
			t.boolean	:is_girl
			t.string	:thumb_img
			t.integer	:friend_count,	:default=>0
			t.boolean	:maintain_login,	:default=>false
			t.string	:account_bank,	:default=>""
			t.string	:account_number,	:default=>""
			t.string	:address_zip_code,	:default=>""
			t.string	:address_detail,	:default=>""
			t.string	:phone_number,	:default=>""
			t.string	:home_number,	:default=>""
			t.integer :good_count,	:default=>0
			t.integer :bad_count,		:default=>0
			t.integer :trade_count,	:default=>0

      t.timestamps
    end
  end
end
