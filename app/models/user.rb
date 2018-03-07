# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string           indexed
#  profile_image_url :text
#  is_admin          :boolean
#  is_superuser      :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ApplicationRecord

  has_many :projects, foreign_key: :owner_id
  has_and_belongs_to_many :subscriptions, class_name: "Project"
  has_many :comments, foreign_key: :owner_id
  has_many :notifications, foreign_key: :user_target_id
  has_many :thumbs_up, foreign_key: :creator_id

  validate :allowed_domain

  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  private
  def allowed_domain
    return if Settings.allowed_domain.blank?
    errors.add(:email, "domain not allowed") unless self.email.match("@#{Settings.allowed_domain}")
  end
end
