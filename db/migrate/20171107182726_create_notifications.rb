class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :project
      t.references :comment
      t.belongs_to :user_related
      t.belongs_to :user_target, index: true
      t.string :notification_type
      t.boolean :visualized, default: false

      t.timestamps
    end
  end
end
