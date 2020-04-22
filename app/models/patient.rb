# frozen_string_literal: true

# Define the Patient model class.
class Patient < ApplicationRecord
  scope :sorted_by_id, -> { order('id ASC') }

  def full_name
    "#{first_name} #{last_name}"
  end

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i.freeze

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, numericality: { only_integer: true },
                    length: { maximum: 10 }
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: EMAIL_REGEX
end
