class ParticipantsController < ApplicationController
  before_action :fetch_current_competition, only: [:create, :new]

  def new
    @participant = Participant.new(competition: @competition)
  end

  def create
    team = Team.create!(participant_params)

    @competition.participants.create!(team: team)

    redirect_to competition_path(@competition)
  end

  private

  def participant_params
    params.required(:participant).permit(:nickname, :hometown)
  end

  def fetch_current_competition
    @competition = Competition.find(params[:competition_id])
  end
end
