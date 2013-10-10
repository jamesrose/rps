class GamesController < ApplicationController
  before_filter :find_game, :find_player
  before_filter :authorise_player_access, only: :show

  respond_to :html, :json

  def new
    open_games = Game.open_games
    if open_games.any?
      game = open_games.first
    else
      game = Game.create
    end
    game.add_player(@player)
    NewPlayerNotification.notify(game, @player)
    redirect_to game
  end

  def show
  end

  def add_move
    @game = Game.find(params[:game_id])
    render json: @game.add_move(@player, params[:move])
  end

  private

  def find_game
    @game = Game.find(params[:id]) if params[:id]
  end

  def authorise_player_access
    redirect_to new_game_path if not @game.players.include?(@player)
  end

  def find_player
    @player = Player.find(session[:player_id]) if session[:player_id]
    redirect_to new_player_path if not @player
  end
end
