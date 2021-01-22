# frozen_string_literal: true

# Define the Patient model class.
class Patient < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, numericality: { only_integer: true },
                    length: { maximum: 10 }
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: Constants::EMAIL_REGEX

  # Returns the patient list orderer by id
  scope :sorted_by_id, -> { order('id ASC') }

  # Returns the patient full name
  def full_name
    "#{first_name} #{last_name}"
  end

end
