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

  # TODO: Test this validation of overlaps
  validate :dates_should_not_overlap

  def active?
    Time.now.between?(registration_start_date, end_date)
  end

  def started?
    Time.now > start_date
  end

  def finished?
    Time.now > end_date
  end

  def self.active_now
    find_by_date(Time.now)
  end

  def self.find_by_date(date, exclude_id: nil)
    result = where(':date BETWEEN registration_start_date AND end_date', date: date)
    result = result.where.not(id: exclude_id) if exclude_id
    result.first
  end

  private
  def dates_should_not_overlap
    [:registration_start_date, :start_date, :end_date].each do |field|
      check_for_overlaping_events_for_date(field)
    end
  end

  def check_for_overlaping_events_for_date(date_field)
    date = self.send(date_field)
    overlap_event = existing_overlaping_event_for(date)
    if overlap_event
      errors.add(date_field,
        "there is an overlap of dates with #{overlap_event.title} event from #{overlap_event.registration_start_date} to #{overlap_event.end_date}"
      )
    end
  end

  def existing_overlaping_event_for(date)
    Edition.find_by_date(date, exclude_id: self.id)
  end
end
