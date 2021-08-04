require 'rails_helper'

RSpec.describe 'competitions show page (/competitions/:id)' do
  let!(:competition1) { Competition.create!(name: "Men's Regional",location: 'Louisville',sport: 'Basketball') }
  let!(:competition2) { Competition.create!(name: 'World Cup', location: 'Brazil', sport: 'Soccer') }
  let!(:competition3) { Competition.create!(name: 'Fiba World Championship', location: 'Austrailia', sport: 'Handball') }

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

  let!(:player1a) { team1.players.create!(name: 'Player 1a', age: 10) }
  let!(:player1b) { team1.players.create!(name: 'Player 1b', age: 10) }
  let!(:player1c) { team1.players.create!(name: 'Player 1c', age: 12) }
  let!(:player1d) { team1.players.create!(name: 'Player 1d', age: 12) }

  let!(:player2a) { team2.players.create!(name: 'Player 2a', age: 12) }
  let!(:player2b) { team2.players.create!(name: 'Player 2b', age: 12) }
  let!(:player2c) { team2.players.create!(name: 'Player 2c', age: 13) }
  let!(:player2d) { team2.players.create!(name: 'Player 2d', age: 14) }
  let!(:player2e) { team2.players.create!(name: 'Player 2e', age: 14) }

  let!(:player3a) { team3.players.create!(name: 'Player 3a', age: 10) }
  let!(:player3b) { team3.players.create!(name: 'Player 3b', age: 12) }
  let!(:player3c) { team3.players.create!(name: 'Player 3c', age: 14) }

  let!(:player4a) { team4.players.create!(name: 'Player 4a', age: 10) }
  let!(:player4b) { team4.players.create!(name: 'Player 4b', age: 10) }
  let!(:player4c) { team4.players.create!(name: 'Player 4c', age: 11) }
  let!(:player4d) { team4.players.create!(name: 'Player 4d', age: 11) }

  let!(:player5a) { team5.players.create!(name: 'Player 5a', age: 10) }
  let!(:player5b) { team5.players.create!(name: 'Player 5b', age: 13) }
  let!(:player5c) { team5.players.create!(name: 'Player 5c', age: 19) }

  specify { expect(Competition.all.count.positive?).to be true }
  specify { expect(Participant.all.count.positive?).to be true }
  specify { expect(Player.all.count.positive?).to be true }
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

      it 'displays the average age of all players in the competition' do
        expect(page).to have_content("Average Player Age: #{competition1.average_player_age.round(1)}")
        expect(page).to have_no_content("Average Player Age: #{competition2.average_player_age.round(1)}")
        expect(page).to have_no_content("Average Player Age: #{competition3.average_player_age.round(1)}")
      end

      it 'displays a link to register a new team' do
        expect(page).to have_link('Register a New Team')
      end

      describe 'when I click the link to register a new team' do
        before { click_link 'Register a New Team' }

        it 'takes me to a new page where I see a form' do
          expect(current_path).to eq(new_competition_participant_path(competition1))
          expect(page).to have_field(:participant_nickname)
          expect(page).to have_field(:participant_hometown)
          expect(page).to have_button('Submit')
        end
      end
    end
  end
end
