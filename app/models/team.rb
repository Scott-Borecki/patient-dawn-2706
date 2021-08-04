class Team < ApplicationRecord
  has_many :participants
  has_many :players
end
