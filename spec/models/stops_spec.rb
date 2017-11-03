require_relative "../rails_helper.rb"
require_relative "../../app/models/stop.rb"

describe Stop do
  context "when the stop doesn't have a name" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, name: nil)
      expect(stop.valid?).to eq false
    end
  end


  context "when the stop doesn't have an optional description" do
    it "should persist" do
      stop = FactoryGirl.build(:stop, description: nil)
      expect(stop.valid?).to eq true
    end
  end

  context "when the stop doesn't have miles_from_k" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, miles_from_k: nil)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has miles_from_k < 593" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, miles_from_k: 592)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has miles_from_k > 684" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, miles_from_k: 685)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has miles_from_k > 598 & < 684" do
    it "should persist" do
      stop = FactoryGirl.build(:stop, miles_from_k: 650)
      expect(stop.valid?).to eq true
    end
  end

  context "when the stop doesn't have miles_from_ga" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, miles_from_ga: nil)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has miles_from_ga < 1505" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, miles_from_ga: 1504)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has miles_from_ga > 1597" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, miles_from_ga: 1598)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has miles_from_ga < 1597 & > 1505" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, miles_from_ga: 1550)
      expect(stop.valid?).to eq true
    end
  end

  context "when the stop has elevation < 0" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, elevation: -2)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has elevation > 3491 (Mass's highest point)" do
    it "should not persist" do
      stop = FactoryGirl.build(:stop, elevation: 4500)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has a reasonable elevation" do
    it "should persist" do
      stop = FactoryGirl.build(:stop, elevation: 2500)
      expect(stop.valid?).to eq true
    end
  end

  context "when the stop has a short description" do
    it "should not persist" do
      text = "This is a short description."
      stop = FactoryGirl.build(:stop, description: text)
      expect(stop.valid?).to eq true
    end
  end

  context "when the stop has a too-long description" do
    it "should not persist" do
      text = "When writing tests it is customary to have a separate corresponding spec file for every class file in your project. These spec files are called unit tests and they will focus on testing individual classes. Let's lay out an example of the convention for how we would set up an Airplane class and its corresponding spec file. Here we have two files: airplane.rb which will contain the class definition and airplane_spec.rb that will contain the tests for that class. Let's start with airplane.rb and provide a bare-bones definition for our class. First we load airplane.rb using require_relative so that we have access to the Airplane class. We can use describe to inform the test suite which class we're testing and provide a location for us to define our tests for this class."
      stop = FactoryGirl.build(:stop, description: text)
      expect(stop.valid?).to eq false
    end
  end

  context "when the stop has stopresources" do
    it ".stopresource should display them" do
      stop = FactoryGirl.create(:stop)
      water = Resource.create(name: "water")
      stopresource = FactoryGirl.create(:stopresource, stop: stop, resource: water)
      expect(stop.stopresources.last).to eq stopresource
    end
  end

  context "when the stop doesn't have stopresources" do
    it ".stopresource should display an empty array" do
      stop = FactoryGirl.create(:stop)
      expect(stop.stopresources).to eq []
    end
  end
end
