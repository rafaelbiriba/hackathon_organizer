class AddExtrasFieldToNotifications < ActiveRecord::Migration[5.1]
  def change
    change_table :notifications do |t|
      t.text :extras
    end
  end
end
