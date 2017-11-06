class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include FontAwesome::Rails::IconHelper
  include Draper::LazyHelpers
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def distance_direction_adder(resource, obj)
    # resource may or may not have a distance/direction from trail. If it does, this method adds those props to obj
    if resource.distance_from_trail
      obj[:distance_from_trail] = resource.distance_from_trail
    end

    if resource.direction_from_trail
      obj[:direction_from_trail] = resource.direction_from_trail
    end
  end

  def icon_adder(obj)
    # obj should have a resource property. This method will add a resource_icon property (icon) that corresponds to the resource
    if obj[:resource] == "bus"
      obj[:resource_icon] = fa_icon "bus", title: "Bus"
    elsif obj[:resource] == "doctor, medical"
      obj[:resource_icon] = fa_icon "hospital-o", title: "Doctor"
    elsif obj[:resource] == "groceries, supplies"
      obj[:resource_icon] = fa_icon "shopping-cart", title: "Groceries"
    elsif obj[:resource] == "short-term resupply"
      obj[:resource_icon] = fa_icon "refresh", title: "Short-term resupply"
    elsif obj[:resource] == "lodging"
      obj[:resource_icon] = fa_icon "bed", title: "Lodging"
    elsif obj[:resource] == "meals, restaurants"
      obj[:resource_icon] = fa_icon "cutlery", title: "Restaurants"
    elsif obj[:resource] == "outfitter"
      obj[:resource_icon] = fa_icon "cog", title: "Outfitter"
    elsif obj[:resource] == "parking"
      obj[:resource_icon] = fa_icon "car", title: "Parking"
    elsif obj[:resource] == "post office"
      obj[:resource_icon] = fa_icon "envelope-o", title: "Post office"
    elsif obj[:resource] == "road access"
      obj[:resource_icon] = fa_icon "road", title: "Road access"
    elsif obj[:resource] == "shelter"
      obj[:resource_icon] = fa_icon "home", title: "Shelter"
    elsif obj[:resource] == "shower"
      obj[:resource_icon] = fa_icon "shower", title: "Shower"
    elsif obj[:resource] == "train"
      obj[:resource_icon] = fa_icon "train", title: "Train"
    elsif obj[:resource] == "water"
      obj[:resource_icon] = fa_icon "tint", title: "Water"
    elsif obj[:resource] == "all"
      obj[:resource_icon] = fa_icon "asterisk", title: "All"
    elsif obj[:resource] == "hostel"
      obj[:resource_icon] = "<i class='fa icon-hostel' title='Hostel'></i>"
    elsif obj[:resource] == "coin laundry"
      obj[:resource_icon] = "<i title='Coin laundry' class='fa icon-coin-laundry' ></i>"
    elsif obj[:resource] == "veterinarian"
      obj[:resource_icon] = "<i class='fa icon-guidedog' title='Veterinarian'></i>"
    elsif obj[:resource] == "fuel"
      obj[:resource_icon] = "<i class='fa icon-fuel' title='Fuel'></i>"
    elsif obj[:resource] == "campsites"
      obj[:resource_icon] = "<i class='fa icon-campsite' title='Campsites'></i>"
    end
  end
end
