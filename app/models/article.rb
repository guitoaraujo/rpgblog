class Article < ApplicationRecord
  belongs_to :user
  belongs_to :rulebook

  has_many :comments, dependent: :destroy

  validates :title, :description, presence: true
end
