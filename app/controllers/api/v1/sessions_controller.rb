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
  end

  private
  def sessions_params
    params.require(:user).permit(:email, :password)
  end
end
