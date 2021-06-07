class Rulebook < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :title, presence: true
end
