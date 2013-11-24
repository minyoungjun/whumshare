class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
			t.integer		:user_id,		:null => false
			t.integer 	:type, 			:default => 0,
															:null => false
			t.string 		:content
			t.string		:readed,		:default => false

      t.timestamps
    end
  end
end
