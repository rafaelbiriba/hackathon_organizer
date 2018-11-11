class Edition < ActiveRecord::Migration[5.1]
  def change
    create_table :editions do |t|
      t.string "title", null: false
      t.datetime "starts_at", null: false
      t.datetime "finishes_at", null: false
    end

    add_reference :projects, :edition, foreign_key: true, index: true
  end
end
