class Court < ActiveRecord::Base
  has_many :matches
  has_many :games, through: :matches
  has_many :players, through: :matches
  before_save(:upcase_court)


  private

  def upcase_court
    array = self.title.split
    array.each do |t|
      t.capitalize!
    end
    self.title = array.join(' ')
  end
end
