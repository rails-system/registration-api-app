class Api::ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :json
  protect_from_forgery with: :null_session
  
  def authenticate_with_token!
    begin
      # payload, header = TokenProvider.valid?(token)
      # @current_user = User.find_by(id: payload['user_id'])
      # @company = Companydatum.find(@current_user.useraccount.companydatum_id) if @current_user.present?
      # @company_control = @company.company_control if @current_user.present?
    rescue
      render json: { errors: "Unauthorized"}, status: 401
    end
  end

  def current_user
    @current_user ||= authenticate_with_token!
  end

  def token
    request.headers['Authorization'].present? ? request.headers['Authorization'].split(' ').last : params[:token]
  end

end