class WorldsController < ApplicationController
  def index
    @worlds = World.all
  end

  def new
    @world = World.new
  end

  def create
    @world = World.new(world_params)

    if @world.save
      redirect_to @world
    else
      flash.now[:errors] = @world.errors.full_messages
      render "new"
    end
  end

  def show
    @world = World.find(params[:id])
  end

  private

  def world_params
    params.require(:world).permit(:title)
  end
end
