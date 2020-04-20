class Patient < ApplicationRecord

  scope :sorted_by_id, lambda { order("id ASC") }
  scope :search, lambda {|query| where(["firstName LIKE ?", "%#{query}%"]) }

end
