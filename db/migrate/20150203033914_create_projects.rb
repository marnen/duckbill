class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :client_id, null: false
      t.string :name, null: false

      t.timestamps null: false
    end

    add_foreign_key :projects, :clients
  end
end
