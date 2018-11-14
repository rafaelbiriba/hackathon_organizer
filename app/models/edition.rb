# == Schema Information
#
# Table name: editions
#
#  id                      :bigint(8)        not null, primary key
#  title                   :string           not null
#  registration_start_date :datetime         not null
#  start_date              :datetime         not null
#  end_date                :datetime         not null
#

class Edition < ApplicationRecord
  has_many :projects, dependent: :destroy

  validates_presence_of :title, :registration_start_date, :start_date, :end_date
  validate :dates_should_not_overlap

  def active?
    Time.now.between?(registration_start_date, end_date)
  end

  def self.active_now
    find_by_date(Time.now)
  end

  def self.find_by_date(date)
    where(':date BETWEEN registration_start_date AND end_date', date: date).first
  end

  private
  def dates_should_not_overlap
    errors.add(:registration_start_date, "there is an overlap of dates") if Edition.find_by_date(registration_start_date)
    errors.add(:start_date, "there is an overlap of dates") if Edition.find_by_date(start_date)
    errors.add(:end_date, "there is an overlap of dates") if Edition.find_by_date(end_date)
  end
end
