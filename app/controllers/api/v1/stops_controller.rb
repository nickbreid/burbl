class Api::V1::StopsController < ApplicationController
  def index
    stops = Stop.where("miles_from_ga >= ?", params[:mile].to_f).limit(10)
    parsed_stops = stops.map do |stop|
      stop_returned = {
        name: stop.name,
        mile_marker: stop.miles_from_ga,
        to_next_point: stop.to_next_point
      }
      stop_resources = stop.stopresources
      unless stop_resources.empty?
        stop_returned[:stop_resources] = []
        stop_resources.each do |stop_resource|
          stop_resources_returned = {
            resource: Resource.find(stop_resource.resource_id).name,
            id: stop_resource.id,
            resource_icon: ''
          }
          distance_direction_adder(stop_resource, stop_resources_returned)
          icon_adder(stop_resources_returned)
          stop_returned[:stop_resources] << stop_resources_returned
        end
      end
      stop_returned
    end
    render json: { status: 'SUCCESS', message: 'Loaded stops', data: parsed_stops }, status: :ok
  end
end
