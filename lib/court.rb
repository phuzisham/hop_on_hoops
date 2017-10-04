class Court < ActiveRecord::Base
  has_many :matches
  has_many :games, through: :matches
  has_many :players, through: :matches
end
