class Competition < ApplicationRecord
  has_many :participants

  def teams
    participants.joins(:team)
      .select('teams.*')
      .distinct
  end
end
