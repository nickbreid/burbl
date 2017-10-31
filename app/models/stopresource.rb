class Stopresource < ApplicationRecord
  belongs_to :stop
  belongs_to :resource
  validates :distance_from_trail, numericality: true, allow_nil: true
end
