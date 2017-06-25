class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def self.hash_of_res_to_listings
    # returns a hash of city res vs. listings per city object
    self.all.each_with_object({}) do |city, city_ratios|
      city_ratios[city] = {}
      city_ratios[city]["listings"] = city.listings.count
      city_ratios[city]["reservations"] = city.listings.inject(0) do |sum, listing|
        sum + listing.reservations.count
      end
    end
  end

  def self.highest_ratio_res_to_listings
    # Assignment: knows the city with the highest ratio of reservations to listings
    # Above I made .ratio_of_res_to_listings to return a hash of city res vs. listings
    city_ratios = self.hash_of_res_to_listings
    # now we have a hash of reservation and listing per city object.
    # next, we just pull the highest_ratio of reservation to listings
    city_ratios.max_by do |city, values|
      values["reservations"] / (values["listings"].nonzero? || 1) #prevents a ZeroDivisionError
    end.first
  end

  def self.most_res
    # Assignment: most_res knows the city with the most reservations
    city_ratios = self.hash_of_res_to_listings
    city_ratios.max_by do |city, values|
      values["reservations"]
    end.first
  end

  def city_openings(start_date, end_date)
    # Assignment: City instance methods knows about all the available listings given a date range
    # I'm going to have to turn start/end date into Date format
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    # Then figure out how to check if dates overlap.
    self.listings.select do |listing|
      listing.reservations.all? do |reservation|
        reservation.checkin > end_date ||
        reservation.checkout < start_date
      end
    end
  end

end
