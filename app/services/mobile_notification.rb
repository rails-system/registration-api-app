require 'twilio-ruby'
module Services
  class MobileNotification
    attr_reader :message, :number
  ​
    def initialize(user)
      @message = "verify OTP #{user.otp}"
      @number = user.number
    end
  ​   
    def call
      send_message
    end

    private

    def send_message
      client = Twilio::REST::Client.new Twilio.account_sid, Twilio.auth_token
      client.messages.create(
        from: '+914242342644',
        to: '+918965961235',
        body: @message
      )
      client
      rescue ::Twilio::REST::RestError => error
        errors.add :sms, error.message
      end
    end
  end
end
