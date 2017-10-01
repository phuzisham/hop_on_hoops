class CreateCourts < ActiveRecord::Migration[5.1]
  def change
    create_table(:courts) do |c|
      c.column(:location, :string)
      c.column(:hoop_count, :integer)
      c.column(:rating, :integer)
      c.column(:description, :string)

      c.timestamps()
    end
  end
end
