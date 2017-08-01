class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.timestamps
    end

    add_index :users, :email
    add_index :users, :username
    add_index :users, :name
  end
end
