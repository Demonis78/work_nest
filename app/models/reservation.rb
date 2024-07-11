# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :venue
  belongs_to :offer
  belongs_to :venue_admin, class_name: 'VenueAdmin', foreign_key: 'venue_admin_id'
  
  validates :venue_id, :offer_id, :venue_admin_id, presence: true
  validate :end_date_after_start_date
  validates :start_date, :end_date, presence: true

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
