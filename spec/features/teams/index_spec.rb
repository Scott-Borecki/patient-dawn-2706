require 'rails_helper'

RSpec.describe 'teams index page (/teams)' do
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

  describe 'as a user' do
    describe 'when I visit the teams index' do
      before { visit teams_path }

      specify { expect(current_path).to eq(teams_path) }

      it 'displays the nicknames of all the teams' do
        Team.all.each do |team|
          expect(page).to have_content(team.nickname)
        end
      end

      it 'displays the average player age of each team' do
        Team.all.each do |team|
          within "#team-#{team.id}" do
            expect(page).to have_content("Average Player Age: #{team.average_player_age.round(1)}")
          end
        end
      end

      xit 'displays the teams by average age from highest to lowest' do
        expect(team5.nickname).to appear_before(team2.nickname)
        expect(team2.nickname).to appear_before(team3.nickname)
        expect(team3.nickname).to appear_before(team1.nickname)
        expect(team1.nickname).to appear_before(team4.nickname)
      end
    end
  end
end
