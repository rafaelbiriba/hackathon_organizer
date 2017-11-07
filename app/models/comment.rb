class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: "User"

  validates_presence_of :body
end
