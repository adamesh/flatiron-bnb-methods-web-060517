class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  def average_review_rating
    #Assignment: knows its average ratings from its reviews
    self.reviews.inject(0) do |sum, review|
      sum + review[:rating].to_f / reviews.length
    end
  end

end
