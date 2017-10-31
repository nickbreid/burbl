class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include FontAwesome::Rails::IconHelper
  include Draper::LazyHelpers
end
