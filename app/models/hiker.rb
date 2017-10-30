class Hiker < ApplicationRecord
  validates :name, presence: true
  validate :mile_must_be_in_range

  private
  def mile_must_be_in_range
    unless miles_from_end > 1505 && miles_from_end < 1597 || miles_from_end > 593 && miles_from_end < 683
      errors.add(:miles_from_end, "must be a mile-marker in Massachusetts")
    end
  end
end
