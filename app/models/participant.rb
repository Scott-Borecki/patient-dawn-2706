class Participant < ApplicationRecord
  belongs_to :competition
  belongs_to :team
end
