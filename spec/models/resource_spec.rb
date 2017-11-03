require_relative "../rails_helper.rb"
require_relative "../../app/models/resource.rb"

describe Resource do
  context "when the resource isn't on the approved list" do
    it "resource should not persist" do
      chicken = Resource.new(name: "chicken wings")
      expect(chicken.valid?).to eq false
    end
  end

  context "when the resource already exists" do
    it "resource should not persist" do
      bus = Resource.new(name: "bus")
      expect(bus.valid?).to eq true
      bus.save
      another_bus = Resource.new(name: "bus")
      expect(another_bus.valid?).to eq false
      expect(another_bus.save).to eq false
    end
  end

  context "when it's the happy path" do
    it "the resource is persisted" do
      camp = Resource.new(name: "campsites")
      expect(camp.valid?).to eq true
      camp.save
      expect(Resource.last).to eq camp
    end
  end

  context "when the resource has stopresources" do
    it ".stopresources should display them" do
      stop = FactoryGirl.create(:stop)
      water = Resource.create(name: "water")
      stopresource = FactoryGirl.create(:stopresource, stop: stop, resource: water)
      expect(water.stopresources.last).to eq stopresource
    end
  end
end
