class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :subscribers, class_name: "User"
end
