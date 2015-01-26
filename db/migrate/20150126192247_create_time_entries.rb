class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.integer :user_id, null: false
      t.date :date, null: false
      t.decimal :hours, precision: 4, scale: 2, null: false
      t.string :description, null: false
      t.text :notes
      t.timestamps null: false
    end
    add_foreign_key :time_entries, :users
  end
end
