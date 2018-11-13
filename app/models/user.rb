# == Schema Information
#
# Table name: users
#
#  id                :bigint(8)        not null, primary key
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

  after_save :validate_profile_image!, if: :should_validate_profile_image?

  validate :allowed_domain

  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def validate_profile_image!
    return unless profile_image_url
    require "rest_client"
    begin
      response_code = RestClient.head(profile_image_url).code
    rescue Exception
    ensure
      remove_profile_image_url! if response_code != 200
    end
  end

  private
  def should_validate_profile_image?
    true if Rails.env.production?
  end

  def remove_profile_image_url!
    update_attributes!(profile_image_url: nil)
  end

  def allowed_domain
    return if Settings.allowed_domain.blank?
    errors.add(:email, "domain not allowed") unless self.email.match("@#{Settings.allowed_domain}")
  end
end
