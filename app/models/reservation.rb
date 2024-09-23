class Reservation < ApplicationRecord
  belongs_to :venue
  belongs_to :offer
  belongs_to :venue_admin, class_name: 'VenueAdmin', foreign_key: 'venue_admin_id'
  has_and_belongs_to_many :variants

  validates :venue_id, :offer_id, :venue_admin_id, :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :dates_available


  def total_price(period = :daily)
    case period
    when :monthly
      months = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
      variants.sum { |variant| variant.price * months }
    else
      days = (end_date - start_date).to_i
      variants.sum { |variant| variant.price * days }
    end
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def dates_available
    overlapping_reservations = venue.reservations.where.not(id: id)
      .where("(start_date, end_date) OVERLAPS (?, ?)", end_date, start_date)

    if overlapping_reservations.exists?
      errors.add(:base, "Wybrany termin jest zajęty dla tego obiektu.")
    end
  end
end
