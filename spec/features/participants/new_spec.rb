require 'rails_helper'

RSpec.describe 'new competition participant page (/competitions/:competition_id/participants/new)' do
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
    describe 'when I visit the new competition participant page' do
      before { visit new_competition_participant_path(competition1) }

      specify { expect(current_path).to eq(new_competition_participant_path(competition1)) }

      it 'displays a form to create a new participant team' do
        expect(page).to have_field(:participant_nickname)
        expect(page).to have_field(:participant_hometown)
        expect(page).to have_button('Submit')
      end

      describe 'when I fill in the form and click submit' do
        before do
          fill_in :participant_nickname, with: 'Celtics'
          fill_in :participant_hometown, with: 'Boston'
          click_button 'Submit'
        end

        it 'redirects me back to the competitions show page' do
          expect(current_path).to eq(competition_path(competition1))
        end

        it 'displays the new team on the competitions show page' do
          expect(page).to have_content('Boston')
          expect(page).to have_content('Celtics')
        end
      end
    end
  end
end
