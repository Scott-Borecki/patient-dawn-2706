require 'rails_helper'

RSpec.describe 'competitions show page (/competitions/:id)' do
  let!(:competition1) do
    Competition.create!(
      name: "Men's Regional",
      location: 'Louisville',
      sport: 'Basketball'
    )
  end

  let!(:competition2) do
    Competition.create!(
      name: 'World Cup',
      location: 'Brazil',
      sport: 'Soccer'
    )
  end

  let!(:competition3) do
    Competition.create!(
      name: 'Fiba World Championship',
      location: 'Austrailia',
      sport: 'Handball'
    )
  end

  let!(:team1) { Team.create!(hometown: 'Lessburg', nickname: 'Rockets') }
  let!(:team2) { Team.create!(hometown: 'Sandwich', nickname: 'Blue Knights') }
  let!(:team3) { Team.create!(hometown: 'Arvada', nickname: 'Mountaineers') }
  let!(:team4) { Team.create!(hometown: 'Jefferson', nickname: 'Spectacles') }
  let!(:team5) { Team.create!(hometown: 'Washington', nickname: 'Cherries') }

  let!(:participant1) {Participant.create!(team: team1, competition: competition1) }
  let!(:participant2) {Participant.create!(team: team2, competition: competition1) }
  let!(:participant3) {Participant.create!(team: team3, competition: competition1) }
  let!(:participant4) {Participant.create!(team: team4, competition: competition2) }
  let!(:participant5) {Participant.create!(team: team5, competition: competition2) }
  let!(:participant6) {Participant.create!(team: team1, competition: competition3) }
  let!(:participant7) {Participant.create!(team: team4, competition: competition3) }
  specify { expect(Competition.all.count.positive?).to be true }
  specify { expect(Team.all.count.positive?).to be true }

  describe 'as a user' do
    describe 'when I visit the competitions show page' do
      before { visit competition_path(competition1) }

      specify { expect(current_path).to eq(competition_path(competition1)) }

      it 'displays the competitions name, location, and sport' do
        expect(page).to have_content(competition1.name)
        expect(page).to have_content(competition1.location)
        expect(page).to have_content(competition1.sport)

        expect(page).to have_no_content(competition2.name)
        expect(page).to have_no_content(competition2.location)
        expect(page).to have_no_content(competition2.sport)

        expect(page).to have_no_content(competition3.name)
        expect(page).to have_no_content(competition3.location)
        expect(page).to have_no_content(competition3.sport)
      end

      context 'when a team is in the competition' do
        it 'displays the nickname and hometown of the team' do
          teams_in_competition = competition1.teams

          teams_in_competition.each do |team|
            within "#team-#{team.id}" do
              expect(page).to have_content(team.nickname)
              expect(page).to have_content(team.hometown)
            end
          end
        end
      end

      context 'when a team is not in the competition' do
        it 'does not display the nickname and hometown of the team' do
          teams_not_in_competition = [team4, team5]

          teams_not_in_competition.each do |team|
            expect(page).to have_no_content(team.nickname)
            expect(page).to have_no_content(team.hometown)
          end
        end
      end
    end
  end
end
