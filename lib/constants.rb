#frozen_string_literal: true

# Module for constants
module Constants
  # Email format validation
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i.freeze
end
