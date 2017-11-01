class Api::V1::StopsController < ApplicationController
  def index
    stops = Stop.all
    parsed_stops = stops.map do |stop|
      return_stop = {
        name: stop.name,
        mile_marker: stop.miles_from_ga,
        to_next_point: stop.to_next_point
      }
      stop_resources = stop.stopresources
      unless stop_resources.empty?
        return_stop[:stop_resources] = []
        stop_resources.each do |sr|
          return_stop_resources = {
            resource: Resource.find(sr.resource_id).name,
            id: sr.id,
            resource_icon: ''
          }
          if sr.distance_from_trail
            return_stop_resources[:distance_from_trail] = sr.distance_from_trail
          end

          if sr.direction_from_trail
            return_stop_resources[:direction_from_trail] = sr.direction_from_trail
          end

          if return_stop_resources[:resource] == "bus"
            return_stop_resources[:resource_icon] = fa_icon "bus", title: "Bus"
          elsif return_stop_resources[:resource] == "doctor, medical"
            return_stop_resources[:resource_icon] = fa_icon "hospital-o", title: "Doctor"
          elsif return_stop_resources[:resource] == "groceries, supplies"
            return_stop_resources[:resource_icon] = fa_icon "shopping-cart", title: "Groceries"
          elsif return_stop_resources[:resource] == "short-term resupply"
            return_stop_resources[:resource_icon] = fa_icon "refresh", title: "Short-term resupply"
          elsif return_stop_resources[:resource] == "lodging"
            return_stop_resources[:resource_icon] = fa_icon "bed", title: "Lodging"
          elsif return_stop_resources[:resource] == "meals, restaurants"
            return_stop_resources[:resource_icon] = fa_icon "cutlery", title: "Restaurants"
          elsif return_stop_resources[:resource] == "outfitter"
            return_stop_resources[:resource_icon] = fa_icon "cog", title: "Outfitter"
          elsif return_stop_resources[:resource] == "parking"
            return_stop_resources[:resource_icon] = fa_icon "car", title: "Parking"
          elsif return_stop_resources[:resource] == "post office"
            return_stop_resources[:resource_icon] = fa_icon "envelope-o", title: "Post office"
          elsif return_stop_resources[:resource] == "road access"
            return_stop_resources[:resource_icon] = fa_icon "road", title: "Road access"
          elsif return_stop_resources[:resource] == "shelter"
            return_stop_resources[:resource_icon] = fa_icon "home", title: "Shelter"
          elsif return_stop_resources[:resource] == "shower"
            return_stop_resources[:resource_icon] = fa_icon "shower", title: "Shower"
          elsif return_stop_resources[:resource] == "train"
            return_stop_resources[:resource_icon] = fa_icon "train", title: "Train"
          elsif return_stop_resources[:resource] == "water"
            return_stop_resources[:resource_icon] = fa_icon "tint", title: "Water"
          elsif return_stop_resources[:resource] == "all"
            return_stop_resources[:resource_icon] = fa_icon "asterisk", title: "All"
          elsif return_stop_resources[:resource] == "hostel"
            return_stop_resources[:resource_icon] = "<i class='fa icon-hostel' title='Hostel'></i>"
          elsif return_stop_resources[:resource] == "coin laundry"
            return_stop_resources[:resource_icon] = "<i title='Coin laundry' class='fa icon-coin-laundry' ></i>"
          elsif return_stop_resources[:resource] == "veterinarian"
            return_stop_resources[:resource_icon] = "<i class='fa icon-guidedog' title='Veterinarian'></i>"
          elsif return_stop_resources[:resource] == "fuel"
            return_stop_resources[:resource_icon] = "<i class='fa icon-fuel' title='Fuel'></i>"
          elsif return_stop_resources[:resource] == "campsites"
            return_stop_resources[:resource_icon] = "<i class='fa icon-campsite' title='Campsites'></i>"
          end

          return_stop[:stop_resources] << return_stop_resources
        end
      end
      return_stop
    end
    render json: { status: 'SUCCESS', message: 'Loaded stops', data: parsed_stops }, status: :ok
  end
end
