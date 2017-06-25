class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  has_many :guests, :through => :listings, :foreign_key => 'host_id'
  # Fuck these associations V Can't get them right. 
  # has_many :hosts, :through => :reservation, :foreign_key => 'guest_id'
  # has_many :reviews, :through => :reservations, :foreign_key => 'host_id'

end
