class ChunksController < ApplicationController
  def new
    @world = World.find(params[:world_id])
    @chunk = @world.chunks.new(world_x: params[:x], world_y: params[:y])
  end

  def create
    @world = World.find(params[:world_id])
    @chunk = @world.chunks.new(chunk_params)

    if @chunk.save
      redirect_to [@chunk.world, @chunk]
    else
      flash.now[:errors] = @chunk.errors.full_messages
      render "new"
    end
  end

  def show
    @world = World.find(params[:world_id])
    @chunk = @world.chunks.find(params[:id])
  end

  def randomize
    @world = World.find(params[:world_id])
    @chunk = @world.chunks.find(params[:id])

    @chunk.randomize!

    if @chunk.save
      redirect_to [@chunk.world, @chunk]
    else
      flash.now[:errors] = @chunk.errors.full_messages
      render "edit"
    end
  end

  def set_tile
    @world = World.find(params[:world_id])
    @chunk = @world.chunks.find(params[:id])
    tile_type = params[:tile_type]

    x, y = params[:location].split(",").map(&:to_i)

    tiles = @chunk.tiles
    tiles[y][x] = tile_type
    @chunk.assign_tiles(tiles)

    if @chunk.save
      redirect_to [@chunk.world, @chunk, tile_type: tile_type]
    else
      flash.now[:errors] = @chunk.errors.full_messages
      render "edit"
    end
  end

  private

  helper_method :tile_classes
  def tile_classes(tile_type, x, y, impassable)
    [
      "tile",
      "tile-#{tile_type}",
      impassable ? "impassable" : nil,
    ].compact.join(" ")
  end

  def chunk_params
    params.require(:chunk).permit(:world_x, :world_y, :tiles_serialized, :impassable_serialized)
  end
end
