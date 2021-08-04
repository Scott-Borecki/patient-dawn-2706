class Competition < ApplicationRecord
  has_many :participants

  def teams
    participants.joins(:team)
      .select('teams.*')
      .distinct
  end

  def average_player_age
    participants.joins(team: :players)
      .average(:age)
  end
end
