class AdminController < ApplicationController
  before_action :authenticate_admin!

  def authenticate_admin!
    if !current_user.admin?
      redirect_to root_path
    end
  end
end
