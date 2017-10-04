class UpdateDatetime < ActiveRecord::Migration[5.1]
  def change
    remove_column(:games, :date, :date)
    remove_column(:games, :time, :time)
    add_column(:games, :time, :datetime)
  end
end
