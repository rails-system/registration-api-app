class Api::ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :json
  protect_from_forgery with: :null_session
  before_action :authenticate
  attr_accessor :current_user

  def logged_in?
    set_current_user
    !!@current_user
  end

  def current_user
    @current_user
  end

  def set_current_user
    if has_valid_auth_type?
      user = User.find_by(api_token: auth_secret[:api_token])
      if user
        @current_user = user
      end
    end
  end

  def authenticate
    unless logged_in?
      render json: {
          success: false,
          error: 'Invalid credentials'
      }, status: :unauthorized
    end
  end

  private
    
    def auth_header
      request.headers['Authorization'].to_s.scan(/Bearer (.*)$/).flatten.last
    end

    def has_valid_auth_type?
      !!request.headers['Authorization'].to_s.scan(/Bearer/).flatten.first
    end

    def auth_secret
      Auth.decode(auth_header) || {}
    end
  # def authenticate_with_token!
  #   begin
  #     # payload, header = TokenProvider.valid?(token)
  #     # @current_user = User.find_by(id: payload['user_id'])
  #     # @company = Companydatum.find(@current_user.useraccount.companydatum_id) if @current_user.present?
  #     # @company_control = @company.company_control if @current_user.present?
  #   rescue
  #     render json: { errors: "Unauthorized"}, status: 401
  #   end
  # end

  # def current_user
  #   @current_user ||= authenticate_with_token!
  # end

  # def token
  #   request.headers['Authorization'].present? ? request.headers['Authorization'].split(' ').last : params[:token]
  # end

end