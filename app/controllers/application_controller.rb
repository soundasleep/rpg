class ApplicationController < ActionController::Base
  def default_world
    World.first
  end
end
