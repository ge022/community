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

ActiveRecord::Schema.define(version: 20180305041159) do

  create_table "article_comments", force: :cascade do |t|
    t.integer "author_id"
    t.text "comment"
    t.integer "article_id"
    t.integer "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "article_type"
    t.string "article_commentable_type"
    t.integer "article_commentable_id"
    t.integer "user_id"
    t.index ["article_id"], name: "index_article_comments_on_article_id"
    t.index ["community_id"], name: "index_article_comments_on_community_id"
    t.index ["user_id"], name: "index_article_comments_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "article"
    t.integer "community_id"
    t.integer "user_id"
    t.index ["community_id"], name: "index_articles_on_community_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "promo"
    t.boolean "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "adminID"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "user_id"
    t.integer "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_events_on_community_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "forum_replies", force: :cascade do |t|
    t.integer "forum_id"
    t.integer "community_id"
    t.text "post"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "forum_commentable_id"
    t.string "forum_commentable_type"
    t.integer "user_id"
    t.index ["community_id"], name: "index_forum_replies_on_community_id"
    t.index ["forum_id"], name: "index_forum_replies_on_forum_id"
    t.index ["user_id"], name: "index_forum_replies_on_user_id"
  end

  create_table "forums", force: :cascade do |t|
    t.integer "community_id"
    t.integer "author_id"
    t.string "title"
    t.text "post"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["community_id"], name: "index_forums_on_community_id"
    t.index ["user_id"], name: "index_forums_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "display_name"
    t.integer "community_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "email"
    t.index ["community_id"], name: "index_members_on_community_id"
    t.index ["user_id"], name: "index_members_on_user_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "authy_id"
    t.datetime "last_sign_in_with_authy"
    t.boolean "authy_enabled", default: false
    t.string "time_zone", default: "UTC"
    t.index ["authy_id"], name: "index_users_on_authy_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
