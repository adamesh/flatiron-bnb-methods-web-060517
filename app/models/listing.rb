class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  before_create :change_host_status
  before_destroy :host_false_without_listings
  validate :address_isnt_blank, :listing_type_isnt_blank, :title_isnt_blank,
            :description_isnt_blank, :price_isnt_blank, :neighborhood_isnt_blank

  def average_review_rating
    #Assignment: knows its average ratings from its reviews
    self.reviews.inject(0) do |sum, review|
      sum + review[:rating].to_f / reviews.length
    end
  end

  def address_isnt_blank
    if self.address == nil
      errors.add(:address, "can't be blank")
    end
  end

  def listing_type_isnt_blank
    if self.address == nil
      errors.add(:listing_type, "can't be blank")
    end
  end

  def title_isnt_blank
    if self.address == nil
      errors.add(:title, "can't be blank")
    end
  end

  def description_isnt_blank
    if self.address == nil
      errors.add(:description, "can't be blank")
    end
  end

  def price_isnt_blank
    if self.address == nil
      errors.add(:price, "can't be blank")
    end
  end

  def neighborhood_isnt_blank
    if self.address == nil
      errors.add(:neighborhood, "can't be blank")
    end
  end

  def change_host_status
    self.host.host = true
    self.host.save
  end

  # This one should work. Not sure what's wrong. 
  def host_false_without_listings
    if self.host.listings == [self]
      self.host.host = false
      self.host.save
    end
  end

end
