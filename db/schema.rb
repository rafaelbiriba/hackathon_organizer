# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180820065613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "project_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_comments_on_owner_id"
    t.index ["project_id"], name: "index_comments_on_project_id"
  end

  create_table "editions", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "registration_start_date", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "project_id"
    t.integer "comment_id"
    t.integer "user_related_id"
    t.integer "user_target_id"
    t.boolean "visualized", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "extras"
    t.string "type"
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["project_id"], name: "index_notifications_on_project_id"
    t.index ["type"], name: "index_notifications_on_type"
    t.index ["user_related_id"], name: "index_notifications_on_user_related_id"
    t.index ["user_target_id", "visualized"], name: "index_notifications_on_user_target_id_and_visualized"
    t.index ["user_target_id"], name: "index_notifications_on_user_target_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.bigint "edition_id"
    t.integer "related_project_id"
    t.index ["edition_id"], name: "index_projects_on_edition_id"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["related_project_id"], name: "index_projects_on_related_project_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "thumbs_up", force: :cascade do |t|
    t.integer "project_id"
    t.integer "creator_id"
    t.index ["creator_id"], name: "index_thumbs_up_on_creator_id"
    t.index ["project_id"], name: "index_thumbs_up_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "profile_image_url"
    t.boolean "is_admin"
    t.boolean "is_superuser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "projects", "editions"
end
