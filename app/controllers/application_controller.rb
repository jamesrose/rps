class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_player
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end
  helper_method :current_player
  before_filter :current_player
end
