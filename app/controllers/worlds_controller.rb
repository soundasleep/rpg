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

  def edit
    @world = World.find(params[:id])
  end

  def update
    @world = World.find(params[:id])
    @world.assign_attributes(world_params)

    if @world.save
      redirect_to @world
    else
      flash.now[:errors] = @world.errors.full_messages
      render "edit"
    end
  end

  def show
    @world = World.find(params[:id])
  end

  private

  def world_params
    params.require(:world).permit(:title, :default_chunk_id, :spawn_x, :spawn_y)
  end
end
