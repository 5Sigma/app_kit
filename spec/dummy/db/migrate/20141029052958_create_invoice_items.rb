class CreateInvoiceItems < ActiveRecord::Migration
    def change
        create_table :invoice_items do |t|
            t.belongs_to :invoice
            t.string :description
            t.decimal :unit_price
            t.decimal :quantity
            t.decimal :extended_price
            t.timestamps
        end
    end
end
