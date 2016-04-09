# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160409064651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_authentications_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "likes_count",  default: 0
    t.string   "ancestry"
    t.index ["ancestry"], name: "index_comments_on_ancestry", using: :btree
    t.index ["micropost_id", "created_at"], name: "index_comments_on_micropost_id_and_created_at", using: :btree
    t.index ["micropost_id"], name: "index_comments_on_micropost_id", using: :btree
    t.index ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_type", "subject_id"], name: "index_likes_on_subject_type_and_subject_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "picture"
    t.integer  "comments_count", default: 0
    t.integer  "likes_count",    default: 0
    t.integer  "source_id",      default: 0
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree
    t.index ["user_id"], name: "index_microposts_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "name"
    t.boolean  "read",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["subject_type", "subject_id"], name: "index_notifications_on_subject_type_and_subject_id", using: :btree
    t.index ["user_id", "created_at"], name: "index_notifications_on_user_id_and_created_at", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "key"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["subject_type", "subject_id"], name: "index_pictures_on_subject_type_and_subject_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "topic_relationships", force: :cascade do |t|
    t.integer  "topic_id"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["subject_type", "subject_id"], name: "index_topic_relationships_on_subject_type_and_subject_id", using: :btree
    t.index ["topic_id"], name: "index_topic_relationships_on_topic_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "content"
    t.text     "guide"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_topics_on_content", using: :btree
    t.index ["user_id"], name: "index_topics_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "activation_token"
    t.boolean  "activated",                    default: false
    t.datetime "activated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_email_send_at"
    t.string   "mentions_permission",          default: "all"
    t.string   "comments_permission",          default: "all"
    t.boolean  "likes_permission",             default: true
    t.string   "access_token"
    t.integer  "microposts_count",             default: 0
    t.integer  "following_count",              default: 0
    t.integer  "followers_count",              default: 0
    t.text     "bio"
    t.string   "avatar"
    t.string   "locale"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "comments", "microposts"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "topic_relationships", "topics"
end
