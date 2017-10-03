class CreateRemoveDatetimeAddDateAndTime < ActiveRecord::Migration[5.1]
  def change
    remove_column(:games, :time, :datetime)
    add_column(:games, :date, :date)
    add_column(:games, :time, :time)
  end
end
