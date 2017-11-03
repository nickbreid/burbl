require_relative "../rails_helper.rb"
require_relative "../../app/models/hiker.rb"

describe Hiker do
  context "if he/she has no mile-marker" do
    it "hiker should not persist" do
      hiker = FactoryGirl.build(:hiker, miles_from_end: nil)
      expect(hiker.valid?).to eq false
    end
  end

  context "if he/she has no name" do
    it "hiker should not persist" do
      hiker = FactoryGirl.build(:hiker, name: nil)
      expect(hiker.valid?).to eq false
    end
  end

  context "if he/she has an invalid mile-marker" do
    it "hiker should not persist" do
      hiker = FactoryGirl.build(:hiker, miles_from_end: 800)
      expect(hiker.valid?).to eq false
    end
  end

  context "if he/she has a northbound mile-marker" do
    it "hiker should persist" do
      hiker = FactoryGirl.build(:hiker, miles_from_end: 1550)
      expect(hiker.valid?).to eq true
    end
  end

  context "if he/she has a southbound mile-marker" do
    it "hiker should persist" do
      hiker = FactoryGirl.build(:hiker, miles_from_end: 600)
      expect(hiker.valid?).to eq true
    end
  end


end
