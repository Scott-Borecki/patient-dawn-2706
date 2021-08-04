class Team < ApplicationRecord
  has_many :competitions, through: :participants
  has_many :participants
  has_many :players

  def self.order_by_average_player_age
    joins(:players)
      .select('teams.*, avg(players.age) AS average_player_age')
      .group(:id)
      .order(average_player_age: :desc)
  end

  # NOTE: This method is only needed for dynamic testing.
  #       See spec/features/teams/index_spec.rb:49
  def average_player_age
    players.average(:age)
  end
end
