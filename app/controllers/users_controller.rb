class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      # User creation successful
      render json: {
        user: {
          username: @user.username,
          email: @user.email
        }
      }
    else
      # User creation failed
      render json: {
        success: false,
        errors: @user.errors.full_messages
      }
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
