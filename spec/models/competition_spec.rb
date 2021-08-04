require 'rails_helper'

RSpec.describe Competition do
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
  specify { expect(Participant.all.count.positive?).to be true }

  describe 'relationships' do
    it { should have_many(:participants) }
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
  end
end
