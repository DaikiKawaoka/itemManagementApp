class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :imgtext
      t.string :comment
      t.string :assessment
      t.integer :type
      t.string :name
      t.boolean :favorite
      t.integer :price
      t.string :purchase_of_place
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :items, [:user_id, :created_at]
  end
end
