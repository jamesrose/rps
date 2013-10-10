require 'test_helper'

class GameTest < ActiveSupport::TestCase
  setup do
    @player_one = Player.new(name: 'James')
    @player_two = Player.new(name: 'Alex')
    @game = Game.new(player_one: @player_one, player_two: @player_two)
  end

  test "#players should return the players partaking in the game" do
    assert_equal @game.players, [@player_one, @player_two]
    @game.player_one = nil
    assert_equal @game.players, [@player_two]
    @game.player_two = nil
    assert_equal @game.players, []
  end

  test "#moves should return the moves in the game" do
    @game.player_one_move = 'rock'
    @game.player_two_move = 'paper'
    assert_equal @game.moves, %w{rock paper}
  end

  test "a game is only #complete when both players have submitted their moves" do
    @game.player_one_move = 'rock'
    @game.player_two_move = 'paper'
    assert @game.complete?
  end

  test "given one player in any game, #second_player returns the other player" do
    assert_equal @game.second_player(@player_one), @player_two
    assert_equal @game.second_player(@player_two), @player_one
  end

  test "#second_players_move returns the secondary players move" do
    @game.player_one_move = 'rock'
    @game.player_two_move = 'paper'
    assert_equal @game.second_players_move(@player_one), @game.player_two_move
  end

  test "Given a player, #player_move should return their move" do
    @game.player_one_move = 'rock'
    @game.player_two_move = 'paper'
    assert_equal @game.player_move(@player_one), 'rock'
    assert_equal @game.player_move(@player_two), 'paper'
  end

  test "#add_player adds a player to a game" do
    @game = Game.new
    @game.add_player @player_one
    assert_equal @game.players, [@player_one]
    @game.add_player @player_two
    assert_equal @game.players, [@player_one, @player_two]
  end

  test "#add_move adds a players move to a game" do
    @game = Game.new(player_one: @player_one, player_two: @player_two)
    @game.add_move(@player_one, 'rock')
    assert_equal @game.moves, %w{ rock }
    assert_equal @game.player_one_move, 'rock'
    @game.add_move(@player_two, 'paper')
    assert_equal @game.moves, %w{ rock paper }
    assert_equal @game.player_two_move, 'paper'
  end

  test "#winner returns the winner, or nil if it's a draw" do
    @game.add_move(@player_one, 'rock')
    @game.add_move(@player_two, 'paper')
    assert_equal @game.winner, @player_two
    
    @game.add_move(@player_one, 'scissors')
    @game.add_move(@player_two, 'paper')
    assert_equal @game.winner, @player_one
    
    @game.add_move(@player_one, 'rock')
    @game.add_move(@player_two, 'rock')
    assert_equal @game.winner, nil
    
    @game.add_move(@player_one, 'paper')
    @game.add_move(@player_two, 'scissors')
    assert_equal @game.winner, @player_two
    
    @game.add_move(@player_one, 'paper')
    @game.add_move(@player_two, 'paper')
    assert_equal @game.winner, nil
  end
end