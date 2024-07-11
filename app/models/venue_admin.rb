class VenueAdmin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  has_many :venues
  has_many :reservations, through: :venues

  validates :company_name, presence: true
end
