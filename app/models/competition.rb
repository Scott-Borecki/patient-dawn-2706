class Competition < ApplicationRecord
  has_many :participants
  has_many :teams, through: :participants

  def average_player_age
    teams.joins(:players)
         .average(:age)
  end
end
