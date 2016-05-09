class Api::V1::UsersController < ApplicationController
  
  # Callbacks
  skip_before_action :responce_of_authentication, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
  end

  def create
    if User.find_by(email: params[:email]).nil?
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: user.errors.messages, status: :unprocessable_entity
      end
      
    else
      render json: { error: 'The user cant be created, the email excist in database' }, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private
  # Strongs parameters
  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password, :celphone)
  end
end
