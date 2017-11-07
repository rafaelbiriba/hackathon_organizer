class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :subscribers, class_name: "User"
  has_many :comments

  validates_presence_of  :title, :description

  def all_involved_users(except_user: nil)
    ([owner] + subscribers - [except_user]).uniq
  end
end
