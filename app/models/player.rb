class Player < ActiveRecord::Base

  # Attributes
  attr_accessible :name

  # Validations
  validates :name, presence: true

  def has_played?(game)
    game.player_one == self && game.player_one_move ||
    game.player_two == self && game.player_two_move
  end
end
