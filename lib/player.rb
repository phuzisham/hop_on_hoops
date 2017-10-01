class Player < ActiveRecord::Base
  has_many :games
  has_many :courts, through: :games
  validates(:name, {:presence => true, :length => {:maximum => 100}})
  validates(:name, uniqueness: { case_sensitive: false })
  before_save(:upcase_name)

  private

  def upcase_name
    array = self.name.split
    array.each do |n|
      n.capitalize!
    end
    self.name = array.join(' ')
  end
end
