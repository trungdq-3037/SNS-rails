class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.integer :user_id
      t.timestamps
    end
  end
end
