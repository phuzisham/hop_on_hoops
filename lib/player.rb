class Player < ActiveRecord::Base
  has_many :games
  has_many :courts, through: :games
  validates(:name, {:presence => true, :length => {:maximum => 50}})
  validates(:user_name, {:presence => true, :length => {:maximum => 30}})
  validates(:user_password, {:presence => true, :length => {:maximum => 30}})
  validates(:user_name, uniqueness: { case_sensitive: false })
  before_save(:upcase_name)
  before_save(:password_hash)
  include BCrypt

  private

  def upcase_name
    array = self.name.split
    array.each do |n|
      n.capitalize!
    end
    self.name = array.join(' ')
  end

  def password_hash
    self.user_password = BCrypt::Password.create(self.user_password)
  end
end
