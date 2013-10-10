require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "#has_played? returns whether this player has played a game" do
    @player_one = Player.new(name: 'James')
    @game = Game.new(player_one: @player_one, player_one_move: 'rock')
    assert @player_one.has_played?(@game)
    @game = Game.new(player_one: @player_one)
    assert !@player_one.has_played?(@game)
    assert !@player_one.has_played?(Game.new)
  end
end