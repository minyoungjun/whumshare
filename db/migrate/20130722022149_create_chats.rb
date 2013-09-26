class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
			t.integer	:room_number
			t.integer	:product_id

			t.integer	:seller_id
			t.integer	:buyer_id
			t.integer	:medi_id
			t.integer	:last_msg_id
			t.integer	:seller_see_msg_id
			t.integer	:buyer_see_msg_id

      t.timestamps
    end
  end
end
