class CreatePasswordColumn < ActiveRecord::Migration[5.1]
  def change
    add_column(:players, :user_name, :string)
    add_column(:players, :user_password, :string)
  end
end
