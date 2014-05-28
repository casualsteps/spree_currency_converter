class AddPresentationCurrencyPriceToOrder < ActiveRecord::Migration
  def change
    add_column :spree_orders, :presentation_currency, :string
    add_column :spree_orders, :presentation_item_total, :decimal, :precision => 10, :scale => 2, :default => 0.0
    add_column :spree_orders, :presentation_adjustment_total, :decimal, :precision => 10, :scale => 2, :default => 0.0
    add_column :spree_orders, :presentation_payment_total, :decimal, :precision => 10, :scale => 2, :default => 0.0
    add_column :spree_orders, :presentation_additional_tax_total, :decimal, :precision => 10, :scale => 2, :default => 0.0
    add_column :spree_orders, :presentation_shipment_total, :decimal,:precision => 10, :scale => 2, :default => 0.0
    add_column :spree_orders, :presentation_included_tax_total, :decimal, :precision => 10, :scale => 2, :default => 0.0
  end
end
