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

      # nobo_or_sobo_setup(nobo, stop, stop_returned)
      if nobo == "false"
        stop_returned = {
          name: stop.name,
          mile_marker: stop.miles_from_k
        }
      else
        stop_returned = {
          name: stop.name,
          mile_marker: stop.miles_from_ga
        }
      end

      # index_info_adder(stop, stop_returned)

      stop_resources = stop.stopresources

      # stop_resources_adder(stop_returned, stop_resources)
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

      #keep
      stop_returned
    end
    render json: { status: 'SUCCESS', message: 'Loaded index of stops', data: parsed_stops }, status: :ok
  end


  def show
    nobo = params[:nobo]
    stop = Stop.find(params[:id])

    # nobo_or_sobo_setup(nobo, stop, stop_returned)
    if nobo == "false"
      stop_returned = {
        name: stop.name,
        description: stop.description,
        mile_marker: stop.miles_from_k,
        town_access: stop.town_access
      }
    else
      stop_returned = {
        name: stop.name,
        description: stop.description,
        mile_marker: stop.miles_from_ga,
        town_access: stop.town_access
      }
    end

    #show_page_info_adder(stop, stop_returned)

    stop_resources = stop.stopresources

    # refactored
    # stop_resources_adder(stop_returned, stop_resources)
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
    render json: { status: 'SUCCESS', message: 'Loaded show page stop data', data: stop_returned }, status: :ok
  end


  private

  def nobo_or_sobo_setup(nobo, raw_stop, stop_returned)
    if nobo == "false"
      stop_returned = {
        name: raw_stop.name,
        mile_marker: raw_stop.miles_from_k
      }
    else
      stop_returned = {
        name: raw_stop.name,
        mile_marker: raw_stop.miles_from_ga
      }
    end
  end

  def show_page_info_adder(raw_stop, stop_returned)
    if raw_stop.description
      let raw_stop[:description] = raw_stop.description
    end

    if raw_stop.town_access
      let raw_stop[:town_access] = raw_stop.town_access
    end
  end

  def stop_resources_adder(stop_returned, stop_resources)
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

  def index_page_adder(raw_stop, stop_returned)
    stop_returned[:to_next_point] = stop.to_next_point
  end

end
