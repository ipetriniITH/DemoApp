# frozen_string_literal: true

module AccessHelper
  def confirm_logged_in
    return if session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(access_login_path)
  end
end
