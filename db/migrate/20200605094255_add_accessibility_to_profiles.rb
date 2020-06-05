class AddAccessibilityToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :accessibility, :integer
  end
end
