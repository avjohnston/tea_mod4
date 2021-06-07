class TeaType < ApplicationRecord
  has_many :subscriptions

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true
end