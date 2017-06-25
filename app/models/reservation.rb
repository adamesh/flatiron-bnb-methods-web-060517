class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validate :checkin_isnt_blank, :checkout_isnt_blank

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

end
