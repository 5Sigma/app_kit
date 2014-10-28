class CreateInvoices < ActiveRecord::Migration
    def change
        create_table :invoices do |t|
            t.belongs_to :customer
            t.string :invoice_number
            t.decimal :invoice_total
            t.datetime :invoice_date
            t.boolean :paid
            t.boolean :published
            t.timestamps
        end
    end
end
