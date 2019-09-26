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

ActiveRecord::Schema.define(version: 2019_09_26_015052) do

  create_table "chunks", force: :cascade do |t|
    t.integer "world_id", null: false
    t.integer "world_x", null: false
    t.integer "world_y", null: false
    t.string "tiles_serialized"
    t.string "impassable_serialized"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["world_id", "world_x", "world_y"], name: "index_chunks_on_world_id_and_world_x_and_world_y"
  end

  create_table "entities", force: :cascade do |t|
    t.integer "chunk_id", null: false
    t.float "chunk_x", null: false
    t.float "chunk_y", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.string "entity_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chunk_id"], name: "index_entities_on_chunk_id"
    t.index ["entity_type"], name: "index_entities_on_entity_type"
  end

  create_table "item_types", force: :cascade do |t|
    t.string "title", null: false
    t.string "rarity", default: "common", null: false
    t.integer "durability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "item_type_id", null: false
    t.integer "player_id"
    t.integer "entity_id"
    t.integer "durability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_items_on_entity_id"
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
    t.index ["player_id"], name: "index_items_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "title", null: false
    t.integer "chunk_id"
    t.float "chunk_x"
    t.float "chunk_y"
    t.integer "level", default: 1, null: false
    t.integer "health", default: 1, null: false
    t.integer "mana", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chunk_id"], name: "index_players_on_chunk_id"
  end

  create_table "worlds", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
