class ParticipantsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @participant = Participant.new(competition: @competition)
  end
end
