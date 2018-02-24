# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  project_id :integer          indexed
#  owner_id   :integer          indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: "User"

  validates_presence_of :body
end
