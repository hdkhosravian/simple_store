# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_23_085935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "title"
    t.string "file"
    t.string "fileable_type"
    t.bigint "fileable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fileable_type", "fileable_id"], name: "index_attachments_on_fileable_type_and_fileable_id"
  end

  create_table "auth_tokens", force: :cascade do |t|
    t.string "token"
    t.string "refresh_token"
    t.datetime "token_expires_at"
    t.datetime "refresh_token_expires_at"
    t.string "tokenable_type", null: false
    t.bigint "tokenable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["refresh_token"], name: "index_auth_tokens_on_refresh_token", unique: true
    t.index ["token"], name: "index_auth_tokens_on_token", unique: true
    t.index ["tokenable_type", "tokenable_id"], name: "index_auth_tokens_on_tokenable_type_and_tokenable_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "sku"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "accessibility"
    t.string "username"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variations", force: :cascade do |t|
    t.string "price"
    t.integer "sku"
    t.integer "quantity"
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_variations_on_product_id"
  end

  add_foreign_key "products", "users"
  add_foreign_key "variations", "products"
end
