class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
			t.integer	:user_id
			t.integer	:evalutation
			t.boolean	:is_seller
			t.text		:comment
			

      t.timestamps
    end
  end
end
