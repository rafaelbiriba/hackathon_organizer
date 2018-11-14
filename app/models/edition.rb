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

  #validate :starts_at_ranges, :finishes_at_ranges

  def active?
    Time.now > registration_start_date && Time.now <= end_date
  end

  private

  # def starts_at_ranges
  #   errors.add(:starts_at, "there is ")
  # end
  #
  # def finishes_at_ranges
  # end
end
