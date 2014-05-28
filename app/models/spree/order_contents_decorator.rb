Spree::OrderContents.class_eval do
  private
    def reload_totals
      order_updater.update_item_count
      order_updater.update_item_total
      order_updater.update_adjustment_total
      order_updater.update_presentation_totals
      order_updater.persist_totals
      order.reload
    end
end
