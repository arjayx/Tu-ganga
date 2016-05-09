class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Callbaks
  before_action :responce_of_authentication

  
  # Methods
  private
  def responce_of_authentication
    authentication_is_valid? || render_unauthorized  
  end

  # Verify if token excist return true or false
  def authentication_is_valid?
    authenticate_with_http_token do |token, options|
      Token.find_by(key: token)
    end
  end

  # Return the responce format
  def render_unauthorized
    render json: { error: "Access unauthorized"}, status: :unautorized
  end
end
