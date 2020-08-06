# frozen_string_literal: true
class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    user = User.new(user_params)
    if user.save
      UserNotifierMailer.send_signup_email(user).deliver_now
      render status: 200, json: user, success: true
    else
      render json: { success: false, message: user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :mobile_number, :otp, :is_verify)
  end
end
