class Stop < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed." }, allow_nil: true
  validates :miles_from_ga, numericality: { greater_than_or_equal_to: 1505, less_than_or_equal_to: 1597 }, uniqueness: true
  validates :miles_from_k, numericality: { greater_than_or_equal_to: 593, less_than_or_equal_to: 684 }, uniqueness: true
  validates :elevation, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3491 }, allow_nil: true
  has_many :stopresources
  has_many :comments

  private
  def mile_must_be_in_range
    if miles_from_end.nil?
      errors.add(:miles_from_end, "can not be nil")
    else
      unless miles_from_end > 1505 && miles_from_end < 1597 || miles_from_end > 593 && miles_from_end < 684
        errors.add(:miles_from_end, "must be a mile-marker in Massachusetts")
      end
    end
  end
end
