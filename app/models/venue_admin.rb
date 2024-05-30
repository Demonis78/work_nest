class VenueAdmin < ApplicationRecord
  belongs_to :company
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :company_name, presence: true
end
