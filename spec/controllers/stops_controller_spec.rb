require "rails_helper"

RSpec.describe Api::V1::StopsController, type: :controller do
  let!(:first_stop) { FactoryGirl.create(:stop, name: "Stop one") }
  let!(:second_stop) { FactoryGirl.create(:stop, name: "Stop two", miles_from_ga: 1555, miles_from_k: 634.8) }
  let!(:third_stop) { FactoryGirl.create(:stop, name: "Stop three", miles_from_ga: 1560, miles_from_k: 629.8) }
  let!(:sixth_stop) { FactoryGirl.create(:stop, name: "Stop six", miles_from_ga: 1575, miles_from_k: 614.8) }
  let!(:fourth_stop) { FactoryGirl.create(:stop, name: "Stop four", miles_from_ga: 1565, miles_from_k: 624.8) }
  let!(:fifth_stop) { FactoryGirl.create(:stop, name: "Stop five", miles_from_ga: 1570, miles_from_k: 619.8) }
  let!(:seventh_stop) { FactoryGirl.create(:stop, name: "Stop seven", miles_from_ga: 1580, miles_from_k: 609.8) }

  describe "GET#index" do
    it "should return only the first six stops sorted by miles_from_ga" do

      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")

      expect(returned_json["data"].length).to eq 6
      expect(returned_json["data"][0]["name"]).to eq "Stop one"
      expect(returned_json["data"][-1]["name"]).to eq "Stop six"

    end

    it "should return only the northbound stops past 1556 and one previous" do

      get :index, params: { nobo: true, mile: 1556 }

      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")

      # these should be the same. Returned_json includes one past stop
      zeroth_stop_name = returned_json["data"][0]["name"]
      prev_stop_name = returned_json["prev_stop"]["name"]

      expect(zeroth_stop_name).to eq prev_stop_name
      expect(zeroth_stop_name).to eq "Stop two"

      # these should also be the same. Returned_json[1] is the impending stop
      first_stop_name = returned_json["data"][1]["name"]
      this_stop_name = returned_json["this_stop"]["name"]

      expect(first_stop_name).to eq this_stop_name
      expect(first_stop_name).to eq "Stop three"


    end

    it "should return only the southbound stops past 633 and one previous" do

      get :index, params: { nobo: false, mile: 633 }

      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")


      # these should be the same. Returned_json includes one past stop
      zeroth_stop_name = returned_json["data"][0]["name"]
      prev_stop_name = returned_json["prev_stop"]["name"]

      expect(zeroth_stop_name).to eq prev_stop_name
      expect(zeroth_stop_name).to eq "Stop three"

      # these should also be the same. Returned_json[1] is the impending stop
      first_stop_name = returned_json["data"][1]["name"]
      this_stop_name = returned_json["this_stop"]["name"]

      expect(first_stop_name).to eq this_stop_name
      expect(first_stop_name).to eq "Stop two"
    end

    it "should return all stops when range is 50" do

      get :index, params: { nobo: true, mile: 1545, range: 50 }

      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(returned_json["data"].length).to eq 7
    end

    it "should return only prev and next stop when range is 5" do

      get :index, params: { nobo: true, mile: 1556, range: 5 }

      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")

      expect(returned_json["data"][0]["name"]).to eq("Stop two")
      expect(returned_json["data"][1]["name"]).to eq("Stop three")
      expect(returned_json["data"].length).to eq 2
    end

    it "should return only sobo prev and next stop when range is 5" do

      get :index, params: { nobo: false, mile: 633, range: 5 }

      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")

      expect(returned_json["data"][0]["name"]).to eq("Stop three")
      expect(returned_json["data"][1]["name"]).to eq("Stop two")
      expect(returned_json["data"].length).to eq 2
    end
  end
end
