class AddUsersAssociationAtProjects < ActiveRecord::Migration[5.1]
  def change
    change_table :projects do |t|
      t.belongs_to :owner, index: true
    end

    create_table :projects_users, id: false do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
    end
  end
end
