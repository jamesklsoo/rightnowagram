class AddStoryToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :story, :string
  end
end
