class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_one_id
      t.string :player_one_move
      t.integer :player_two_id
      t.string :player_two_move

      t.timestamps
    end
  end
end
