class CreateAuthTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.string :refresh_token
      t.datetime :token_expires_at
      t.datetime :refresh_token_expires_at
      t.references :tokenable, polymorphic: true, null: false

      t.timestamps
    end
    add_index :auth_tokens, :token,           unique: true
    add_index :auth_tokens, :refresh_token,   unique: true
  end
end
