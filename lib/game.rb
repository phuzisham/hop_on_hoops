class Game < ActiveRecord::Base
  has_many :courts
  has_many :players, through: :courts
  validates(:game_name, {:presence => true, :length => {:maximum => 100}})
  validates(:game_name, uniqueness: { case_sensitive: false })
  before_save(:upcase_title)

  private

  def upcase_title
    array = self.game_name.split
    array.each do |t|
      t.capitalize!
    end
    self.game_name = array.join(' ')
  end
end
