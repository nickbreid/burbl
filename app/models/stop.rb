class Stop < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 500, too_long: "%{count} characters us the maximum allowed." }, allow_nil: true
  validates :miles_from_ga, numericality: { greater_than_or_equal_to: 1500, less_than_or_equal_to: 1593 }, uniqueness: true
  validates :elevation, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3491 }, allow_nil: true
end
