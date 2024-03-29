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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130727093149) do

  create_table "attacks", :force => true do |t|
    t.string   "name"
    t.integer  "pp"
    t.integer  "power"
    t.integer  "accuracy"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "battle_actions", :force => true do |t|
    t.integer  "turn_id"
    t.integer  "user_id"
    t.integer  "opponent_id"
    t.integer  "pet_id"
    t.integer  "opponent_pet_id"
    t.string   "type"
    t.integer  "attack_id"
    t.integer  "pet_damage",             :default => 0
    t.integer  "opponent_pet_damage",    :default => 0
    t.integer  "pet_status_id"
    t.integer  "opponent_pet_status_id"
    t.boolean  "run_successful",         :default => false
    t.integer  "item_id"
    t.integer  "item_target_id"
    t.integer  "switch_to_pet_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "owner_type"
    t.boolean  "battle_finished"
  end

  add_index "battle_actions", ["turn_id", "created_at"], :name => "index_battle_actions_on_turn_id_and_created_at"

  create_table "battles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "opponent_id"
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.integer  "money_transferred"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "finished",          :default => false
  end

  add_index "battles", ["loser_id", "created_at"], :name => "index_battles_on_loser_id_and_created_at"
  add_index "battles", ["opponent_id", "created_at"], :name => "index_battles_on_opponent_id_and_created_at"
  add_index "battles", ["user_id", "created_at"], :name => "index_battles_on_user_id_and_created_at"
  add_index "battles", ["winner_id", "created_at"], :name => "index_battles_on_winner_id_and_created_at"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category"
    t.integer  "price"
    t.boolean  "in_store"
    t.boolean  "in_battle"
    t.boolean  "can_sell"
    t.integer  "unlock_level"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "opponent_pets", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "type"
    t.integer  "level",                :default => 1
    t.integer  "experience",           :default => 0
    t.integer  "experience_rate",      :default => 0
    t.integer  "attack",               :default => 0
    t.integer  "attack_rate",          :default => 0
    t.integer  "special_attack",       :default => 0
    t.integer  "special_attack_rate",  :default => 0
    t.integer  "defense",              :default => 0
    t.integer  "defense_rate",         :default => 0
    t.integer  "special_defense",      :default => 0
    t.integer  "special_defense_rate", :default => 0
    t.integer  "speed",                :default => 0
    t.integer  "speed_rate",           :default => 0
    t.integer  "catch_rate",           :default => 0
    t.integer  "curr_hp",              :default => 20
    t.integer  "max_hp",               :default => 20
    t.integer  "opponent_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "pet_id"
  end

  add_index "opponent_pets", ["opponent_id", "created_at"], :name => "index_opponent_pets_on_opponent_id_and_created_at"

  create_table "opponents", :force => true do |t|
    t.integer  "skill_level", :default => 1
    t.integer  "money",       :default => 0
    t.integer  "bank",        :default => 0
    t.integer  "money_rate",  :default => 0
    t.integer  "energy",      :default => 0
    t.integer  "energy_rate", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "username"
    t.string   "character"
    t.integer  "user_id"
  end

  add_index "opponents", ["user_id", "created_at"], :name => "index_opponents_on_user_id_and_created_at"

  create_table "pet_attacks", :force => true do |t|
    t.integer  "pet_id"
    t.integer  "attack_id"
    t.integer  "pp"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pet_attacks", ["attack_id", "created_at"], :name => "index_pet_attacks_on_attack_id_and_created_at"
  add_index "pet_attacks", ["pet_id", "created_at"], :name => "index_pet_attacks_on_pet_id_and_created_at"

  create_table "pets", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "type"
    t.integer  "level",                :default => 1
    t.integer  "experience",           :default => 0
    t.integer  "experience_rate",      :default => 0
    t.integer  "attack",               :default => 0
    t.integer  "attack_rate",          :default => 0
    t.integer  "special_attack",       :default => 0
    t.integer  "special_attack_rate",  :default => 0
    t.integer  "defense",              :default => 0
    t.integer  "defense_rate",         :default => 0
    t.integer  "special_defense",      :default => 0
    t.integer  "special_defense_rate", :default => 0
    t.integer  "speed",                :default => 0
    t.integer  "speed_rate",           :default => 0
    t.integer  "catch_rate",           :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "curr_hp",              :default => 20
    t.integer  "max_hp",               :default => 20
  end

  add_index "pets", ["user_id", "created_at"], :name => "index_pets_on_user_id_and_created_at"

  create_table "turns", :force => true do |t|
    t.integer  "battle_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "turns", ["battle_id", "created_at"], :name => "index_turns_on_battle_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",             :default => false
    t.string   "app_id"
    t.string   "character"
    t.integer  "skill_level",       :default => 1
    t.integer  "money",             :default => 0
    t.integer  "bank",              :default => 0
    t.integer  "money_rate",        :default => 0
    t.integer  "energy",            :default => 0
    t.integer  "energy_rate",       :default => 0
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "in_battle",         :default => false
    t.integer  "wins",              :default => 0
    t.integer  "losses",            :default => 0
    t.integer  "passive_wins",      :default => 0
    t.integer  "passive_losses",    :default => 0
    t.integer  "run_aways",         :default => 0
    t.integer  "passive_run_aways", :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
