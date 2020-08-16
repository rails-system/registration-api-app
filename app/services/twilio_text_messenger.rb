class TwilioTextMessenger
  attr_reader :message,:error

  def initialize(user)
    @message = "verify OTP #{user.verify_otp}"
  end

  def call
    client = Twilio::REST::Client.new Twilio.account_sid, Twilio.auth_token
    begin
    client.messages.create({
      from: '+14242342644',
      to: '+918965961235',
      body: @message
    })
    return true
    rescue Twilio::REST::RestError => error
      return error
    end
  end

end