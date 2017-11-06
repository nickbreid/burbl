class Api::V1::StopsController < ApplicationController
  def index
    mile = params[:mile].to_f
    nobo = params[:nobo]

    if nobo == "false"
      stops = Stop.where("miles_from_k >= ?", mile).to_a.sort_by { |stop| stop.miles_from_ga }.reverse
      stops = stops[0..3]
      prev_stop = Stop.where("miles_from_k < ?", mile).first
      this_stop = stops.first
      if prev_stop
        stops.unshift(prev_stop)
      end
    else
      stops = Stop.where("miles_from_ga >= ?", mile).to_a.sort_by { |stop| stop.miles_from_ga }
      stops = stops[0..3]
      prev_stop = Stop.where("miles_from_ga < ?", mile).last
      this_stop = stops.first
      if prev_stop
        stops.unshift(prev_stop)
      end
    end

    parsed_stops = stops.map do |stop|

      stop_returned = nobo_or_sobo_setup(nobo, stop, stop_returned)

      stop_resources = stop.stopresources

      stop_resources_handler(stop_returned, stop_resources)

      stop_returned
    end
    render json: { status: 'SUCCESS', message: 'Loaded index of stops', data: parsed_stops, prev_stop: prev_stop, this_stop: this_stop }, status: :ok
  end


  def show
    nobo = params[:nobo]
    stop = Stop.find(params[:id])
    mile = params[:mile]

    if mile
      nobo_water = nearest_water_finder("nobo", mile)
      sobo_water = nearest_water_finder("sobo", mile)
    end

    stop_returned = nobo_or_sobo_setup(nobo, stop, stop_returned)

    show_page_info_adder(stop, stop_returned)

    stop_resources = stop.stopresources

    stop_resources_handler(stop_returned, stop_resources)

    render json: { status: 'SUCCESS', message: 'Loaded show page stop data', data: stop_returned, nobo_water: nobo_water, sobo_water: sobo_water }, status: :ok
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
      stop_returned[:description] = raw_stop.description
    end

    if raw_stop.town_access
      stop_returned[:town_access] = raw_stop.town_access
    end

    if raw_stop.photo_url
      stop_returned[:photo_url] = raw_stop.photo_url
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

  def nearest_water_finder(direction, mile)
    if direction == "nobo"
      counter = 0
      i = 0
      holder_array = []

      stops = Stop.where("miles_from_ga >= ?", mile).to_a.sort_by { |stop| stop.miles_from_ga }
    elsif direction == "sobo"
      counter = 0
      i = 0
      holder_array = []

      mile = 2189.8 - mile.to_f
      stops = Stop.where("miles_from_k >= ?", mile).to_a.sort_by { |stop| stop.miles_from_ga }.reverse
    end



    loop do
      if stops[i].stopresources
        stop_resources = stops[i].stopresources
        stop_resources.each do |stop_resource|
          if stop_resource.resource_id == 20
            stop_returned = {
              id: stops[i].id,
              miles_from_ga: stops[i].miles_from_ga,
              miles_from_k: stops[i].miles_from_k,
              name: stops[i].name
            }
            holder_array << stop_returned
            counter += 1
          end
        end
        i += 1
        break if counter >= 3 || i >= stops.length
      end
    end
    holder_array
  end

end
