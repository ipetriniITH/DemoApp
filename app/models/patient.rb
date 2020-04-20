class Patient < ApplicationRecord

  scope :sorted_by_id, lambda { order("id ASC") }
  scope :search, lambda {|query| where(["firstName LIKE ?", "%#{query}%"]) }

  def fullName
   "#{firstName} #{lastName}"
  end

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates_presence_of :firstName
  validates_presence_of :lastName
  validates_length_of :phone, :maximum => 10
  validates :phone, numericality: { only_integer: true },
                    length: { :maximum => 100}
  validates :email, presence: true,
                    length: { :maximum => 100},
                    format: EMAIL_REGEX

end
