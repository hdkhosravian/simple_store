class CreateProductOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :variation_options do |t|
      t.references :variation, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
