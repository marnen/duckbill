class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :time_zone, null: false, default: 'Eastern Time (US & Canada)'
    end
  end
end
