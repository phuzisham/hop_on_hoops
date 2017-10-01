class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table(:players) do |t|
      t.column(:name, :string)
      t.column(:rank, :integer)

      t.timestamps()
    end
  end
end
