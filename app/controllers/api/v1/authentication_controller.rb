class Api::V1::AuthenticationController < ApplicationController
  # api :post, '/api/v1/authentication/verify_otp'  params: [:email/mobile_number, otp]
  def verify_otp
    if ( params[:email] || params[:mobile_number] ) && params[:otp].present?
      user = User.where('email = ? or mobile_number = ?', params[:email], params[:phone]).first rescue nil
      if user.present? && user.otp == params[:otp]
        user.update(is_verify: true)
        render json: { success: true, user: user, message: 'verified OTP' }, status: 200
      else
        render json: { success: false, message: 'otp or email or mobile number is not valid' }, status: 200
      end
    else
      render json: { success: false, message: 'invalid parameters' }, status: 200
    end
  end
end