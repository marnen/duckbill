class AddAdditionalFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :company
      t.string :street
      t.string :city
      t.string :state, limit: 2
      t.string :zip
    end
  end
end
