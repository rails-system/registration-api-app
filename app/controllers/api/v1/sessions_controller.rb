class Api::V1::SessionsController < Api::ApiController
  skip_before_action :authenticate, only: [:create]

  def create
    login = auth_params[:email] || auth_params[:mobile_nunber]
    user = User.where(["mobile_number = :value OR email = :value", {value: login.downcase}]).first  
    if user.present? && user.valid_password?(auth_params[:password])
      jwt = Auth.issue({user: user.id})
      time = 24.hours.from_now
      resource.update_attribute(:api_token, jwt)
      render json: {
        success: true,
        auth_token: jwt,
        exp: time.strftime("%m-%d-%Y %H:%M"),
      }, status: :created and return
    else
      render json: {
        success: false,
        error: 'Invalid Credentials'
      }, status: :unauthorized and return
    end
  end

  def logout
    api_user = User.find_by(api_token: params[:api_token])
    api_user.update_attribute(:api_token, nil)
    render json: {:success => true, :message => "Logout successfully"}, status: 200
  end

  private
    
    def auth_params
       params.require(:user).permit(:email, :password, :password_confirmation, :mobile_number, :verify_otp)
    end
end
