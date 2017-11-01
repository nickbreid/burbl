class Api::V1::StopsController < ApplicationController
  def index
    mile = params[:mile].to_f
    nobo = params[:nobo]

    if nobo == "false"
      stops = Stop.where("miles_from_k >= ?", mile).order(:miles_from_k).limit(10)
    else
      stops = Stop.where("miles_from_ga >= ?", mile).limit(10)
    end

    parsed_stops = stops.map do |stop|

      if nobo == "false"
        stop_returned = {
          name: stop.name,
          mile_marker: stop.miles_from_k,
          to_next_point: stop.to_next_point
        }
      else
        stop_returned = {
          name: stop.name,
          mile_marker: stop.miles_from_ga,
          to_next_point: stop.to_next_point
        }
      end

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
