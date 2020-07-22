class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.text :body
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
