module VenuesHelper
  def venue_image_url(venue)
    city = venue.address&.city&.downcase

    case city
    when 'warszawa', 'warsaw', 'Warszawa', 'Warsaw'
      'https://images.pexels.com/photos/672532/pexels-photo-672532.jpeg?auto=compress&cs=tinysrgb&w=800'
    when 'kraków', 'krakow', 'Krakow', 'Kraków'
      'https://images.pexels.com/photos/460680/pexels-photo-460680.jpeg?auto=compress&cs=tinysrgb&w=800'
    when 'wrocław', 'wroclaw', 'Wrocław', 'Wroclaw'
      'https://images.pexels.com/photos/290518/pexels-photo-290518.jpeg?auto=compress&cs=tinysrgb&w=800'
    when 'poznan', 'poznań', 'Poznan', 'Poznań'
      'https://images.pexels.com/photos/290519/pexels-photo-290519.jpeg?auto=compress&cs=tinysrgb&w=800'
    else
      'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&w=800'
    end
  end
end
