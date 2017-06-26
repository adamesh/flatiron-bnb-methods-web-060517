class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review


  validate :checkin_isnt_blank, :checkout_isnt_blank, :res_own_listing, :checkin_before_checkout, :check_available?


  def duration
    #Assignment: knows about its duration based on checkin and checkout dates
    (self.checkout - self.checkin).to_i
  end

  def total_price
    #Assignment: knows about its total price
    (self.listing.price.to_f) * self.duration
  end

  def checkin_isnt_blank
    if self.checkin == nil
      errors.add(:checkin, "can't be blank")
    end
  end

  def checkout_isnt_blank
    if self.checkout == nil
      errors.add(:checkout, "can't be blank")
    end
  end

  def res_own_listing
    if self.guest == self.listing.host
      errors.add(:checkout, "cannot make a reservation on your own listing")
    end
  end

  def res_own_listing
    if self.guest == self.listing.host
      errors.add(:checkout, "cannot make a reservation on your own listing")
    end
  end

  def checkin_before_checkout
# validates that checkin is before checkout
# validates that checkin and checkout dates are not the same
    if self.checkin == nil || self.checkout == nil
      nil
    elsif self.checkin >= self.checkout
      errors.add(:checkin, "checkin must be after checkout")
    end
  end

  def check_available?
# validates that a listing is available at checkin before making reservation
    all_dates = []
    if self.listing.reservations == []
      nil
    elsif self.checkin == nil || self.checkout == nil
      nil
    else
      all_dates = self.listing.reservations.inject([]) do |array, res|
        array << {checkin: res.checkin, checkout: res.checkout}
      end
      # At this point, my all_dates works.

#CODE BELOW BREAKS A LOT OF TESTS, BUT CORRECTLY VALIDATES. MUST BE REWORKED
      # if all_dates.any? do |res|
      #     self.checkout > res[:checkin] &&
      #     self.checkin < res[:checkout]
      #     errors.add(:checkin, "unavailable")
      #   end
      # end

    end
  end

end
