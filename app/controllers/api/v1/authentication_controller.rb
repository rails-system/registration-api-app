class Api::V1::AuthenticationController < Api::ApiController
  # api :post, '/api/v1/authentication/verify_otp'  params: [:email/mobile_number, otp]
  skip_before_action :authenticate, only: [:create]
  def verify_otp
    if ( params[:email] || params[:mobile_number] ) && params[:verify_otp].present?
      user = User.where('email = ? or mobile_number = ?', params[:email], params[:mobile_number]).first rescue nil
      if user.present? && user.verify_otp == params[:verify_otp]
        user.update(is_verified: true)
        render json: { success: true, user: user, message: 'verified OTP' }, status: 200
      else
        render json: { success: false, message: 'verify otp or email or mobile number is not valid' }, status: 200
      end
    else
      render json: { success: false, message: 'invalid parameters' }, status: 200
    end
  end
end