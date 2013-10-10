class PlayersController < ApplicationController
  respond_to :html

  def new
    @player = Player.new
  end

  def create
    player = Player.create(params[:player])
    session[:player_id] = player.id
    respond_with(player, location: new_game_path)
  end
end
