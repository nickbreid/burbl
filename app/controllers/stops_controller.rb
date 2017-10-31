class StopsController < ApplicationController
  def index
    @stops = Stop.all
  end

  def show
  end
end
