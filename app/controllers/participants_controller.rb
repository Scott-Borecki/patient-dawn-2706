class ParticipantsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @participant = Participant.new(competition: @competition)
  end

  def create
    competition = Competition.find(params[:competition_id])
    team = Team.create!(participant_params)

    competition.participants.create!(team: team)

    redirect_to competition_path(competition)
  end

  private

  def participant_params
    params.required(:participant).permit(:nickname, :hometown)
  end
end
