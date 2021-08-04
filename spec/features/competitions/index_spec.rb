require 'rails_helper'

RSpec.describe 'competitions index page (/competitions)' do
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
    describe 'when I visit the competition index' do
      before { visit competitions_path }

      specify { expect(current_path).to eq(competitions_path) }

      it 'displays the names of all the competitions' do
        Competition.all.each do |competition|
          expect(page).to have_content(competition.name)
        end
      end

      it 'displays links to the competitions show page' do
        Competition.all.each do |competition|
          expect(page).to have_link(competition.name)
        end
      end

      it 'links to the competitions show page' do
        Competition.all.each do |competition|
          visit competitions_path
          click_link competition.name

          expect(current_path).to eq(competition_path(competition))
        end
      end
    end
  end
end
