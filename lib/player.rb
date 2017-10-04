class Player < ActiveRecord::Base
  has_many :matches
  has_many :courts, through: :matches
  has_many :games, through: :matches
  validates(:name, {:presence => true, :length => {:maximum => 50}})
  validates(:user_name, {:presence => true, :length => {:maximum => 30}})
  validates(:user_password, {:presence => true, :length => {:maximum => 30}})
  validates(:user_name, uniqueness: { case_sensitive: false })
  before_save(:upcase_name)
  before_save(:hash_pass)
  include BCrypt

  def auth_pass(password, hash)
    BCrypt::Password.new(hash) == password
  end

  private

  def upcase_name
    array = self.name.split
    array.each do |n|
      n.capitalize!
    end
    self.name = array.join(' ')
  end

  def hash_pass()
    self.user_password=(BCrypt::Password.create(user_password).to_s)
  end
end
