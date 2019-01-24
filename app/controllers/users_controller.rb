class UsersController < ApplicationController
  before_action :user
  before_action :ensure_can_manage, only: [ :edit, :update ]

  def show
  end

  def edit
  end

  def update
    if user.update(user_params)
      flash[:notice] = 'User updated successfully'
      redirect_to user_path(user)
    else
      render :edit
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def ensure_can_manage
    if !can_edit?
      redirect_to user_path(@user)
    end
  end

  def can_edit?
    current_user && current_user === @user || current_user.admin?
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
    )
  end
end
