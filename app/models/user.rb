class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  has_many :guests, :through => :listings, :foreign_key => 'host_id'
  has_many :host_reviews, :through => :listings, :source => "reviews"
  # Test for the one below doesn't pass, but I believe it's the correct association.
  # Maybe needs a save methods somewhere?
  has_many :hosts, :through => :listings, :foreign_key => 'guest_id'

end
