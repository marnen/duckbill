class AddDateFormatToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_format, :string, null: false, default: 'db'
  end
end
