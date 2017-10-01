class CreateTitleColumn < ActiveRecord::Migration[5.1]
  def change
    add_column(:courts, :title, :string)
  end
end
