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

  specify { expect(Competition.all.count.positive?).to be true }

  describe 'as a user' do
    describe 'when I visit the competitions show page' do
      it 'displays the competitions name, location, and sport' do
        visit competition_path(competition1)

        expect(current_path).to eq(competition_path(competition1))
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

      it 'displays the nickname and hometown of all the teams in this competition'

      it 'displays the average age of all players in the competition'
    end
  end
end
