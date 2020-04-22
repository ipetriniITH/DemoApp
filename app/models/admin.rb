# frozen_string_literal: true

# Define the Admin model class.
class Admin < ApplicationRecord
  has_secure_password

  # Usernames that are not allowed
  FORBIDDEN_USERNAMES = %w[fstuer jlove].freeze

  validates :username, length: { within: 8..25 },
                       uniqueness: true
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: Constants::EMAIL_REGEX,
                    confirmation: true
  validate :username_is_allowed

  private

  # Check if username is valid
  def username_is_allowed
    errors.add(:username, 'forbidden') if FORBIDDEN_USERNAMES.include?(username)
  end
end
