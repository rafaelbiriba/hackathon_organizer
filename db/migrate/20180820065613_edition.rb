class Edition < ActiveRecord::Migration[5.1]
  def change
    create_table :editions do |t|
      t.string "title", null: false
      t.datetime "registration_start_date", null: false
      t.datetime "start_date", null: false
      t.datetime "end_date", null: false
    end

    add_reference :projects, :edition, foreign_key: true, index: true

    add_column :projects, :related_project_id, :integer
    add_index :projects, :related_project_id
  end
end
