class TeamsController < ApplicationController
  def index
    @teams = Team.order_by_average_player_age
  end
end
