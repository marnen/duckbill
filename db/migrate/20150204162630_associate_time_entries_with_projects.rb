class AssociateTimeEntriesWithProjects < ActiveRecord::Migration
  def up
    change_table :time_entries do |t|
      t.integer :project_id
    end
    add_foreign_key :time_entries, :projects

    TimeEntry.reset_column_information
    TimeEntry.all.each do |time_entry|
      time_entry.update_attribute :project_id, time_entry.user.projects.find_or_create_by_name('Unknown Project').id
    end

    remove_column :time_entries, :user_id
    change_column :time_entries, :project_id, :integer, null: false
  end

  def down
    change_table :time_entries do |t|
      t.integer :user_id
    end
    add_foreign_key :time_entries, :users

    TimeEntry.reset_column_information
    TimeEntry.all.each do |time_entry|
      time_entry.update_attribute :user_id, time_entry.project.user_id
    end

    remove_column :time_entries, :project_id
    change_column :time_entries, :user_id, :integer, null: false
  end
end
