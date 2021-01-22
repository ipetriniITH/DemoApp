# frozen_string_literal: true

# Define test helpers module
module SessionHelpers
  require 'access_controller'

  def login_as_admin
    admin = Admin.create(
      username: 'username',
      password: 'password',
      email: 'email@email.com'
    )
    post access_attempt_login_path, params: { username: 'username', password: 'password' }
  end
end
