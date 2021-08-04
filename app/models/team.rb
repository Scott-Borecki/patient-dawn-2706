class Team < ApplicationRecord
  has_many :participants
  has_many :players

  def average_player_age
    players.average(:age)
  end
end
