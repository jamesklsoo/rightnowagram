class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.belongs_to :post, index: true, foreign_key: true
      t.timestamps
    end

    add_column :likes, :user_id, :integer
  end
end
