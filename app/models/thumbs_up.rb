# == Schema Information
#
# Table name: thumbs_up
#
#  id         :integer          not null, primary key
#  project_id :integer          indexed
#  creator_id :integer          indexed
#

class ThumbsUp < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: "User"
end
