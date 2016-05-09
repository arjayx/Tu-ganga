class Api::V1::SessionsController < ApplicationController
  
  # Callbacks
  skip_before_action :responce_of_authentication, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(sessions_params)
    unless user.nil?
      key = Token.new(user: user)
      if key.save
        render json: key, status: :created
      else
        render json: { error: "have occurred a problem generating the token"}, status: :service_unavailable 
      end
  	end
  end

  def destroy
    
    authenticate_with_http_token do |token, options|
      key = Token.find_by(key: token)
      puts "Este es el token #{key}"
      unless key.nil?
        if key.destroy
          render json: { message: "Logout successfull"}, status: :ok
        else
          render json: { message: "Problems in Logout", ststus:   :internal_server_error}
        end
      else
        render json: {error: "Token no found"}, status: :not_found
      end
    end
  end

  private
  def sessions_params
    params.require(:user).permit(:email, :password)
  end
end
