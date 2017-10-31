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
            return_stop_resources[:resource_icon] = fa_icon "bus"
          elsif return_stop_resources[:resource] == "doctor, medical"
            return_stop_resources[:resource_icon] = fa_icon "hospital-o"
          elsif return_stop_resources[:resource] == "groceries, supplies"
            return_stop_resources[:resource_icon] = fa_icon "shopping-cart"
          elsif return_stop_resources[:resource] == "short-term resupply"
            return_stop_resources[:resource_icon] = fa_icon "refresh"
          elsif return_stop_resources[:resource] == "lodging"
            return_stop_resources[:resource_icon] = fa_icon "bed"
          elsif return_stop_resources[:resource] == "meals, restaurants"
            return_stop_resources[:resource_icon] = fa_icon "cutlery"
          elsif return_stop_resources[:resource] == "outfitter"
            return_stop_resources[:resource_icon] = fa_icon "cog"
          elsif return_stop_resources[:resource] == "parking"
            return_stop_resources[:resource_icon] = fa_icon "car"
          elsif return_stop_resources[:resource] == "post office"
            return_stop_resources[:resource_icon] = fa_icon "envelope-o"
          elsif return_stop_resources[:resource] == "road access"
            return_stop_resources[:resource_icon] = fa_icon "road"
          elsif return_stop_resources[:resource] == "shelter"
            return_stop_resources[:resource_icon] = fa_icon "home"
          elsif return_stop_resources[:resource] == "shower"
            return_stop_resources[:resource_icon] = fa_icon "shower"
          elsif return_stop_resources[:resource] == "train"
            return_stop_resources[:resource_icon] = fa_icon "train"
          elsif return_stop_resources[:resource] == "water"
            return_stop_resources[:resource_icon] = fa_icon "tint"
          elsif return_stop_resources[:resource] == "all"
            return_stop_resources[:resource_icon] = fa_icon "asterisk"
          elsif return_stop_resources[:resource] == "hostel"
            return_stop_resources[:resource_icon] = "<i class='icon-hostel'></i>"
          elsif return_stop_resources[:resource] == "coin laundry"
            return_stop_resources[:resource_icon] = "<i class='icon-coin-laundry'></i>"
          elsif return_stop_resources[:resource] == "veterinarian"
            return_stop_resources[:resource_icon] = "<i class='icon-guidedog'></i>"
          elsif return_stop_resources[:resource] == "fuel"
            return_stop_resources[:resource_icon] = "<i class='icon-fuel'></i>"
          elsif return_stop_resources[:resource] == "campsites"
            return_stop_resources[:resource_icon] = "<i class='icon-campsite'></i>"
            # missing: hostel, cl
          end

          return_stop[:stop_resources] << return_stop_resources
        end
      end
      return_stop
    end
    render json: { status: 'SUCCESS', message: 'Loaded stops', data: parsed_stops }, status: :ok
  end
end
