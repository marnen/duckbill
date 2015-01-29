class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :user_id, null: false
      t.string :name
      t.string :company
      t.string :email
      t.string :street
      t.string :city
      t.string :state, limit: 2
      t.string :zip

      t.timestamps null: false
    end
    add_foreign_key :clients, :users
  end
end
