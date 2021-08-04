require 'rails_helper'

RSpec.describe Team do
  let!(:team1) { Team.create!(hometown: 'Lessburg', nickname: 'Rockets') }
  let!(:team2) { Team.create!(hometown: 'Sandwich', nickname: 'Blue Knights') }
  let!(:team3) { Team.create!(hometown: 'Arvada', nickname: 'Mountaineers') }
  let!(:team4) { Team.create!(hometown: 'Jefferson', nickname: 'Spectacles') }
  let!(:team5) { Team.create!(hometown: 'Washington', nickname: 'Cherries') }

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

  specify { expect(Player.all.count.positive?).to be true }
  specify { expect(Team.all.count.positive?).to be true }

  describe 'relationships' do
    it { should have_many(:participants) }
    it { should have_many(:players) }
  end

  describe 'class methods' do
    describe '.order_by_average_player_age' do
      it 'orders the teams by average player age (highest to lowest)' do
        expected = [team5, team2, team3, team1, team4]
        expect(Team.order_by_average_player_age).to eq(expected)
      end
    end
  end

  describe 'instance methods' do
    describe '#average_player_age' do
      it 'returns the average player age of the team' do
        expect(team1.average_player_age.round(1)).to eq(11)
        expect(team2.average_player_age.round(1)).to eq(13)
        expect(team3.average_player_age.round(1)).to eq(12)
        expect(team4.average_player_age.round(1)).to eq(10.5)
        expect(team5.average_player_age.round(1)).to eq(14)
      end
    end
  end
end
