class CreateVariations < ActiveRecord::Migration[6.0]
  def change
    create_table :variations do |t|
      t.string :price
      t.integer :sku
      t.integer :quantity
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
