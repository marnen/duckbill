class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :project_id, null: false

      t.timestamps null: false
    end

    add_foreign_key :invoices, :projects

    change_table :time_entries do |t|
      t.integer :invoice_id
    end

    add_foreign_key :time_entries, :invoices
  end
end
