class Resource < ApplicationRecord
  validates :name, inclusion: { in: ["bus", "campsites", "coin laundry", "doctor, medical", "fuel", "groceries, supplies", "short-term resupply", "hostel", "lodging", "meals, restaurants", "outfitter", "parking", "post office", "road access", "shelter", "shower", "train", "no potable water", "veterinarian", "water", "all"] }, uniqueness: true
  has_many :stopresources

end
