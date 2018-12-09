class UsersController < ApplicationController
  before_action :user
  before_action :ensure_can_edit, only: [ :edit, :update ]

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

  def ensure_can_edit
    if !can_edit?
      redirect_to user_path(@user)
    end
  end

  def can_edit?
    current_user && current_user === @user
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
    )
  end
end
