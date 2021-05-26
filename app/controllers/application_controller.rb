class ApplicationController < ActionController::Base
  helper_method :current_wallet
  def current_wallet
    @current_wallet ||= current_user.try(:wallet)
  end
end
