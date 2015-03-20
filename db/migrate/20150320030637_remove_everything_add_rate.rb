class RemoveEverythingAddRate < ActiveRecord::Migration
  def change
    add_column :spree_orders, :rate, :decimal, precision: 10, scale: 2, default: 0.0
    
    Spree::Order.complete.where.not(presentation_total: 0.0).each do |order|
      order.update_column(:rate, order.presentation_total / order.total)
    end

    drop_table :spree_currency_rates
    remove_column :spree_orders, :presentation_currency
    remove_column :spree_orders, :presentation_item_total
    remove_column :spree_orders, :presentation_adjustment_total
    remove_column :spree_orders, :presentation_payment_total
    remove_column :spree_orders, :presentation_additional_tax_total
    remove_column :spree_orders, :presentation_shipment_total
    remove_column :spree_orders, :presentation_included_tax_total
    remove_column :spree_orders, :presentation_total
  end
end
