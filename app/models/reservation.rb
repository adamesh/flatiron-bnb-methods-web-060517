class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  def duration
    #Assignment: knows about its duration based on checkin and checkout dates
    (self.checkout - self.checkin).to_i
  end

  def total_price
    #Assignment: knows about its total price
    (self.listing.price.to_f) * self.duration
  end

end
