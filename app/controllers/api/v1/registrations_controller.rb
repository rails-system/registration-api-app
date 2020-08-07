# frozen_string_literal: true
class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    user = User.new(user_params)
    User.added_temp_email(user,params)	unless params[:user][:email].present?
	    if user.save
	      if params[:user][:email].present?
	        UserNotifierMailer.verify_email_otp(user).deliver_now
	      else
	        status = TwilioTextMessenger.new(user).call
	        unless status == true
	        	user.destroy
	        	@message = "Invalid Phone number" 
	      	end
	      end
	      if @message
	      	render status: 422, json: { success: false, message: @message }
	      else
	      	render status: 200, json: user, success: true
	      end	
	    else
	      render json: { success: false, message: user.errors.full_messages }, status: 422
	    end  
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,:password_confirmation, :mobile_number, :verify_otp)
  end
end