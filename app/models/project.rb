# == Schema Information
#
# Table name: projects
#
#  id                 :bigint(8)        not null, primary key
#  title              :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  owner_id           :integer          indexed
#  edition_id         :bigint(8)        indexed
#  related_project_id :integer          indexed
#
# Foreign Keys
#
#  fk_rails_...  (edition_id => editions.id)
#

class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :subscribers, class_name: "User"
  has_many :comments, -> { order( created_at: :asc) }, dependent: :destroy
  has_many :thumbs_up, dependent: :destroy
  belongs_to :edition

  has_one :related_project, class_name: "Project", foreign_key: :related_project_id

  validates_presence_of :title, :description

  before_destroy :destroy_notifications

  def all_involved_users(except_user: nil, include_commenters: false)
    users = [owner] + subscribers
    users = users + comments.collect(&:owner) if include_commenters
    users = users - [except_user]
    users.uniq
  end

  def load_related_project(id)
    seld.related_project = self.find(id)
  end

  private

  def destroy_notifications
    Notification.where(project: self).destroy_all
  end
end
