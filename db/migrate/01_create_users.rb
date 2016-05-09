class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,     null: false
      t.string :lastname, null: false
      t.string :email,    null: false
      t.string :password, null: false
      t.string :celphone, null: false

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
