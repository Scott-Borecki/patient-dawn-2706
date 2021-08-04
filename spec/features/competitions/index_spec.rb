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

  specify { expect(Competition.all.count.positive?).to be true }

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
