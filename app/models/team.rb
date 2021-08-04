class Team < ApplicationRecord
  has_many :participants
  has_many :players

  def self.order_by_average_player_age
    joins(:players)
      .select('teams.*, avg(players.age) AS average_player_age')
      .group(:id)
      .order(average_player_age: :desc)
  end

  def average_player_age
    players.average(:age)
  end
end
