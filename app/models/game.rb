class Game < ActiveRecord::Base

  VALID_MOVES = %w{rock paper scissors}

  attr_accessible :player_one, :player_two, :player_one_move, :player_two_move

  # Validations
  validates :player_one, presence: true, on: :update
  validates :player_one_move, inclusion: { in: VALID_MOVES }, if: Proc.new { |game| !game.player_one_move.blank? }
  validates :player_two_move, inclusion: { in: VALID_MOVES }, if: Proc.new { |game| !game.player_two_move.blank? }

  # Associations
  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'

  def self.open_games
    where(player_two_id: nil)
  end

  # Returns players who have joined the game.
  def players
    [player_one, player_two].compact
  end

  # Returns current moves in the game.
  def moves
    [player_one_move, player_two_move].compact
  end

  def complete?
    moves.size == 2
  end

  def second_player(current_player)
    (players - [current_player]).first
  end

  # Given a player, what is the other players move?
  def second_players_move(current_player)
    player = second_player(current_player)
    player_move(player)
  end

  # Given a player, what was their move in this game?
  def player_move(player)
    if player_one == player
      player_one_move
    elsif player_two == player
      player_two_move
    else
      nil
    end
  end

  # Add a player to a game.
  def add_player(player)
    new_player = if player_one
      { player_two: player }
    else
      { player_one: player }
    end
    update_attributes(new_player)
  end

  # Given a player, add a move to this game.
  def add_move(player, move)
    new_move = if player_one == player
      { player_one_move: move }
    elsif player_two == player
      { player_two_move: move }
    else
      {}
    end
    update_attributes(new_move)
  end

  # Who is the winner of this game?
  def winner
    return nil if player_one_move == player_two_move
    winning_combinations = { 'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock' }
    {
      true => player_one,
      false => player_two,
    }[winning_combinations[player_one_move] == player_two_move]
  end
end
