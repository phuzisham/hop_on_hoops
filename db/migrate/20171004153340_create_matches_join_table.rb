class CreateMatchesJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:matches) do |c|
      c.column(:game_id, :integer)
      c.column(:player_id, :integer)
      c.column(:court_id, :integer)


      c.timestamps()
    end
    remove_column(:courts, :player_id, :integer)
    remove_column(:courts, :game_id, :integer)
  end
end
