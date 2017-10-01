class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table(:games) do |g|
      g.column(:court_id, :integer)
      g.column(:player_id, :integer)
      g.column(:time, :datetime)

      g.timestamps()
    end
  end
end
