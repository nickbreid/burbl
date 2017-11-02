class Api::V1::StopsController < ApplicationController
  def index
    mile = params[:mile].to_f
    nobo = params[:nobo]

    if nobo == "false"
      stops = Stop.where("miles_from_k >= ?", mile).order(:miles_from_k).limit(4).to_a
      prev_stop = Stop.where("miles_from_k < ?", mile).first
      this_stop = stops.first
      if prev_stop
        stops.unshift(prev_stop)
      end
    else
      stops = Stop.where("miles_from_ga >= ?", mile).limit(4).to_a
      prev_stop = Stop.where("miles_from_ga < ?", mile).last
      this_stop = stops.first
      if prev_stop
        stops.unshift(prev_stop)
      end
    end

    parsed_stops = stops.map do |stop|

      stop_returned = nobo_or_sobo_setup(nobo, stop, stop_returned)

      index_info_adder(stop, stop_returned)

      stop_resources = stop.stopresources

      stop_resources_handler(stop_returned, stop_resources)

      stop_returned
    end
    render json: { status: 'SUCCESS', message: 'Loaded index of stops', data: parsed_stops, prev_stop: prev_stop, this_stop: this_stop }, status: :ok
  end


  def show
    nobo = params[:nobo]
    stop = Stop.find(params[:id])

    stop_returned = nobo_or_sobo_setup(nobo, stop, stop_returned)

    show_page_info_adder(stop, stop_returned)

    stop_resources = stop.stopresources

    stop_resources_handler(stop_returned, stop_resources)

    render json: { status: 'SUCCESS', message: 'Loaded show page stop data', data: stop_returned }, status: :ok
  end


  private

  def nobo_or_sobo_setup(nobo, raw_stop, stop_returned)
    if nobo == "false"
      stop_returned = {
        id: raw_stop.id,
        name: raw_stop.name,
        mile_marker: raw_stop.miles_from_k
      }
    else
      stop_returned = {
        id: raw_stop.id,
        name: raw_stop.name,
        mile_marker: raw_stop.miles_from_ga
      }
    end
    stop_returned
  end

  def show_page_info_adder(raw_stop, stop_returned)
    if raw_stop.description
      raw_stop[:description] = raw_stop.description
    end

    if raw_stop.town_access
      raw_stop[:town_access] = raw_stop.town_access
    end
  end

  def stop_resources_handler(stop_returned, stop_resources)
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
  end

  def index_info_adder(raw_stop, stop_returned)
    stop_returned[:to_next_point] = raw_stop.to_next_point
  end

end
