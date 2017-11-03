require_relative "../rails_helper.rb"
require_relative "../../app/models/stopresource.rb"

describe Stopresource do
  context "stopresource doesn't have a stop_id" do
    it "should not persist" do
      resource = FactoryGirl.create(:resource)
      stopresource = FactoryGirl.build(:stopresource, resource: resource)
      expect(stopresource.valid?).to eq false
    end
  end

  context "stopresource doesn't have a resource_id" do
    it "should not persist" do
      stop = FactoryGirl.create(:stop)
      stopresource = FactoryGirl.build(:stopresource, stop: stop)
      expect(stopresource.valid?).to eq false
    end
  end

  context "stopresource has a non-numerical distance_from_trail" do
    it "should not persist" do
      stop = FactoryGirl.create(:stop)
      resource = FactoryGirl.create(:resource)
      stopresource =
       FactoryGirl.build(:stopresource, stop: stop, resource: resource, distance_from_trail: "G")
      expect(stopresource.valid?).to eq false
    end
  end

  context "stopresource has a non-numerical distance_from_trail" do
    it "should not persist" do
      stop = FactoryGirl.create(:stop)
      resource = FactoryGirl.create(:resource)
      stopresource =
       FactoryGirl.build(:stopresource, stop: stop, resource: resource, distance_from_trail: "0.7m")
      expect(stopresource.valid?).to eq false
    end
  end

  context "happy path with no optional distance/direction" do
    it "should persist" do
      stop = FactoryGirl.create(:stop)
      resource = FactoryGirl.create(:resource)
      stopresource =
       FactoryGirl.build(:stopresource, stop: stop, resource: resource)
      expect(stopresource.valid?).to eq true
    end
  end

  context "happy path with valid distance/direction" do
    it "should persist" do
      stop = FactoryGirl.create(:stop)
      resource = FactoryGirl.create(:resource)
      stopresource =
       FactoryGirl.build(:stopresource, stop: stop, resource: resource, distance_from_trail: 0.7, direction_from_trail: "E")
      expect(stopresource.valid?).to eq true
    end
  end


end
