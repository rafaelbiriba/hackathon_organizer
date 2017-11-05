class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text   :profile_image_url
      t.boolean :is_admin

      t.timestamps
    end
  end
end
