class AddPurchaseDateToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :purchase_date, :date
  end
end
