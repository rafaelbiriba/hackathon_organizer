class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :project, foreign_key: true
      t.belongs_to :owner, index: true

      t.timestamps
    end
  end
end
