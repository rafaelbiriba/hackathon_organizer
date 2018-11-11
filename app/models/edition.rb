# == Schema Information
#
# Table name: editions
#
#  id          :bigint(8)        not null, primary key
#  title       :string           not null
#  starts_at   :datetime         not null
#  finishes_at :datetime         not null
#

class Edition < ApplicationRecord
  has_many :projects, dependent: :destroy

  #validate :starts_at_ranges, :finishes_at_ranges

  def active?
    Time.now > starts_at  && Time.now <= finishes_at
  end

  private

  # def starts_at_ranges
  #   errors.add(:starts_at, "there is ")
  # end
  #
  # def finishes_at_ranges
  # end
end
