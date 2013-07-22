class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
			t.string	:room_number
			t.string	:seller_id
			t.string	:buyer_id
			t.string	:medi_id
			t.integer	:last_msg_id
			t.integer	:seller_see_msg_id
			t.integer	:buyer_see_msg_id

      t.timestamps
    end
  end
end
