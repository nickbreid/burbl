class Api::V1::StopsController < ApplicationController
  def index
    stops = Stop.all.limit(10)
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
            id: sr.id
          }
          if sr.distance_from_trail
            return_stop_resources[:distance_from_trail] = sr.distance_from_trail
          end

          if sr.direction_from_trail
            return_stop_resources[:direction_from_trail] = sr.direction_from_trail
          end

          return_stop[:stop_resources] << return_stop_resources
        end
      end
      return_stop
    end
    render json: { status: 'SUCCESS', message: 'Loaded stops', data: parsed_stops }, status: :ok
  end
end
