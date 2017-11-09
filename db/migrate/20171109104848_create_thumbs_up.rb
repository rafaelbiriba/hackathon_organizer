class CreateThumbsUp < ActiveRecord::Migration[5.1]
  def change
    create_table :thumbs_up do |t|
      t.references :project, index: true
      t.belongs_to :creator
    end
  end
end
