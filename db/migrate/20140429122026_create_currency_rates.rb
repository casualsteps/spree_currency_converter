class CreateCurrencyRates < ActiveRecord::Migration
  def change
    create_table :spree_currency_rates do |t|
      t.float :rate, :null => false, :precision => 10, :scale => 4
      t.string :base_currency, :null => false, :default => 'USD'
      t.string :target_currency, :null => false, :default => 'KRW'
      t.timestamps
    end
  end
end
