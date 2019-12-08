class ApplicationController < ActionController::Base
  include SessionsHelper

  def check_logged_in
    if !logged_in?
      redirect_to login_path
    end
  end
end
