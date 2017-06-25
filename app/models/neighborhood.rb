class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def self.hash_of_res_to_listings
    # returns a hash of hood res vs. listings per hood object
    self.all.each_with_object({}) do |hood, hood_ratios|
      hood_ratios[hood] = {}
      hood_ratios[hood]["listings"] = hood.listings.count
      hood_ratios[hood]["reservations"] = hood.listings.inject(0) do |sum, listing|
        sum + listing.reservations.count
      end
    end
  end

  def self.highest_ratio_res_to_listings
    # Assignment: knows the hood with the highest ratio of reservations to listings
    # Above I made .ratio_of_res_to_listings to return a hash of hood res vs. listings
    hood_ratios = self.hash_of_res_to_listings
    # now we have a hash of reservation and listing per hood object.
    # next, we just pull the highest_ratio of reservation to listings

    hood_ratios.max_by do |hood, values|
      values["reservations"] / (values["listings"].nonzero? || 1) #prevents a ZeroDivisionError
    end.first
  end

  def self.most_res
    # Assignment: most_res knows the hood with the most reservations
    hood_ratios = self.hash_of_res_to_listings
    hood_ratios.max_by do |hood, values|
      values["reservations"]
    end.first
  end

  def neighborhood_openings(start_date, end_date)
    # Assignment: hood instance methods knows about all the available listings given a date range
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
