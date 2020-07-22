class AddAddressToStories < ActiveRecord::Migration[6.0]
  def change
    add_column :stories, :address, :string
  end
end
