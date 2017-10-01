class Game < ActiveRecord::Base
  belongs_to :court
  belongs_to :player
end
