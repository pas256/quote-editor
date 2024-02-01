class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  # Uncomment below to see the progress bar
  # before_action -> { sleep 3 }

  private

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end
  helper_method :current_company

end
