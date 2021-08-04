require 'rails_helper'

RSpec.describe Competition do
  let!(:competition1) { Competition.create!(name: "Men's Regional",location: 'Louisville',sport: 'Basketball') }
  let!(:competition2) { Competition.create!(name: 'World Cup', location: 'Brazil', sport: 'Soccer') }
  let!(:competition3) { Competition.create!(name: 'Fiba World Championship', location: 'Austrailia', sport: 'Handball') }

  let!(:team1) { Team.create!(hometown: 'Lessburg', nickname: 'Rockets') } # average_player_age #=> 11
  let!(:team2) { Team.create!(hometown: 'Sandwich', nickname: 'Blue Knights') } # average_player_age #=> 13
  let!(:team3) { Team.create!(hometown: 'Arvada', nickname: 'Mountaineers') } # average_player_age #=> 12
  let!(:team4) { Team.create!(hometown: 'Jefferson', nickname: 'Spectacles') } # average_player_age #=> 10.5
  let!(:team5) { Team.create!(hometown: 'Washington', nickname: 'Cherries') } # average_player_age #=> 14

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

  describe 'relationships' do
    it { should have_many(:participants) }
    it { should have_many(:teams).through(:participants) }
  end

  describe 'instance methods' do
    describe '#teams' do
      it 'returns the teams in the competition' do
        expect(competition1.teams.count).to eq(3)
        expect(competition1.teams[0].nickname).to eq(team1.nickname)
        expect(competition1.teams[0].hometown).to eq(team1.hometown)
        expect(competition1.teams[1].nickname).to eq(team2.nickname)
        expect(competition1.teams[1].hometown).to eq(team2.hometown)
        expect(competition1.teams[2].nickname).to eq(team3.nickname)
        expect(competition1.teams[2].hometown).to eq(team3.hometown)

        expect(competition2.teams.count).to eq(2)

        expect(competition3.teams.count).to eq(2)
      end
    end

    describe '#average_player_age' do
      it 'returns the average player age in the competition' do
        expect(competition1.average_player_age.round(1)).to eq(12.1)
        expect(competition2.average_player_age.round(1)).to eq(12.0)
        expect(competition3.average_player_age.round(1)).to eq(10.8)
      end
    end
  end
end
