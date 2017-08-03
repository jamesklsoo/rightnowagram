class CreateBuyings < ActiveRecord::Migration[5.1]
  def change
    create_table :buyings do |t|

      t.timestamps
    end
  end
end
