class User < ApplicationRecord

  has_many :projects, foreign_key: :owner_id
  has_and_belongs_to_many :subscriptions, class_name: "Project"

  validates_presence_of :name
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
