class MovePlayerAndCourtIdsFromGamesToCourts < ActiveRecord::Migration[5.1]
  def change
    remove_column(:games, :player_id, :integer)
    remove_column(:games, :court_id, :integer)
    add_column(:courts, :player_id, :integer)
    add_column(:courts, :game_id, :integer)
  end
end
