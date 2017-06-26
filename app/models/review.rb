class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validate :rating_valid?, :description_valid?, :reservation_valid?

  def rating_valid?
    if self.rating == nil
      errors.add(:rating, "can't be blank")
    end
  end

  def description_valid?
    if self.description == nil
      errors.add(:description, "can't be blank")
    end
  end

  def reservation_valid?
    # Assignment: review validations is invalid without an
    # associated reservation, has been accepted, and checkout has happened
    if self.reservation_id == nil
      errors.add(:reservation, "is invalid")
    elsif self.reservation.status == "pending"
      errors.add(:reservation, "is invalid")
    elsif self.reservation.checkout > Date.today
      errors.add(:reservation, "is invalid")
    end
  end

end
