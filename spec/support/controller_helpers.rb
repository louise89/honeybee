module ControllerHelpers
  def sign_in(user = User.new)
    # Added from https://github.com/plataformatec/devise/wiki/How-To:-Stub-authentication-in-controller-specs
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    end

    allow(controller).to receive_messages(current_user: user)
  end

  def sign_out
    allow(controller).to receive(:current_user).and_return(nil)
  end
end
