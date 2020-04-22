# frozen_string_literal: true

# Define the Admin model class.
class Admin < ApplicationRecord
  has_secure_password

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i.freeze
  FORBIDDEN_USERNAMES = %w[fstuer jlove].freeze

  validates :username, length: { within: 8..25 },
                       uniqueness: true
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: EMAIL_REGEX,
                    confirmation: true
  validate :username_is_allowed

  private

  def username_is_allowed
    errors.add(:username, 'forbidden') if FORBIDDEN_USERNAMES.include?(username)
  end
end
