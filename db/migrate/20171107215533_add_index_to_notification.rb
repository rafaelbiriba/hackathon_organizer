class AddIndexToNotification < ActiveRecord::Migration[5.1]
  def change
    add_index(:notifications, [:user_target_id, :visualized])
  end
end
