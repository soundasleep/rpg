class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @player.respawn_in_world(default_world)

    if @player.save
      redirect_to @player
    else
      flash.now[:errors] = @player.errors.full_messages
      render "new"
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @player.assign_attributes(player_params)

    if @player.save
      redirect_to @player
    else
      flash.now[:errors] = @player.errors.full_messages
      render "edit"
    end
  end

  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @player.to_public_json }
    end
  end

  def respawn_in_default_world
    @player = Player.find(params[:id])
    @player.respawn_in_world(default_world)

    if @player.save
      redirect_to @player
    else
      flash.now[:errors] = @player.errors.full_messages
      render "edit"
    end
  end

  private

  def player_params
    params.require(:player).permit(:title, :level, :chunk_id, :chunk_x, :chunk_y)
  end
end
