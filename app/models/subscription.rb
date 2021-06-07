class Subscription < ApplicationRecord
  belongs_to :tea_type
  belongs_to :customer

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true

  enum status: [:active, :cancelled]
end