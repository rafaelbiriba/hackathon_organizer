class ThumbsUp < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: "User"
end
