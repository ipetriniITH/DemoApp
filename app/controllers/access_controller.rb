# frozen_string_literal: true

# Define actions for handling user access.
class AccessController < ApplicationController
  include AccessHelper

  before_action :confirm_logged_in, only: %i[menu]

  # GET /access/menu
  # Show admin menu panel.
  def menu; end

  # GET /access/login
  # Show login form.
  def login; end

  # POST /access/login
  # Attempt to login user or show error message.
  def attempt_login
    if params[:username].present? && params[:password].present?
      user = Admin.where(username: params[:username]).first
      if user
        authorized_user = user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = 'Welcome!'
      redirect_to(admin_path)
    else
      flash.now[:notice] = 'Invalid username/password combination.'
      render('login')
    end
  end

  # GET /access/logout
  # Logout current user and show message.
  def logout
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to(access_login_path)
  end
end
