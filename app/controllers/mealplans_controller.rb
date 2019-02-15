class MealplansController < ApplicationController
  before_action :require_login
  before_action :ensure_can_manage, only: [:edit, :update, :destroy]
  before_action :mealplan, except: [:create, :new, :index]

  def index
    @mealplans = current_user.mealplans
  end

  def show
  end

  def new
    @mealplan = Mealplan.new
  end

  def create
    @mealplan = Mealplan.new(create_params)

    if @mealplan.save
      flash[:notice] = 'Congratulations - mealplan created'
      redirect_to edit_mealplan_path(@mealplan)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if mealplan.update(update_params)
      flash[:notice] = 'Edit Saved'
      redirect_to mealplan
    else
      flash[:alert] = 'Edit Not Saved'
      redirect_to edit_mealplan_path(mealplan)
    end
  end

  def destroy
    mealplan.destroy

    flash[:notice] = 'Mealplan was successfully deleted.'
    redirect_to root_path
  end

  private

  def require_login
    if !user_signed_in?
      flash[:alert] = 'You need to sign in'

      redirect_to root_path
    end
  end

  def mealplan
    @mealplan ||= Mealplan.find(params[:id])
  end

  def ensure_can_manage
    if !helpers.can_edit?(mealplan)
      flash[:alert] = 'You cannot edit another person\'s mealplan!'

      redirect_to mealplan_path(mealplan)
    end
  end

  def create_params
    params.require(:mealplan).permit(:status, :name, :user_id)
  end

  def update_params
    params.require(:mealplan).permit(:status, :name)
  end

  def creator
    MealplanCreator.new(@mealplan)
  end
end
