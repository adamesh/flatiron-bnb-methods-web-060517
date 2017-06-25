class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validate :rating_isnt_blank, :description_isnt_blank

  def rating_isnt_blank
    if self.rating == nil
      errors.add(:rating, "can't be blank")
    end
  end

  def description_isnt_blank
    if self.description == nil
      errors.add(:description, "can't be blank")
    end
  end

end
