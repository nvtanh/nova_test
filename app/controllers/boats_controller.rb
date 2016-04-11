class BoatsController < ApplicationController
  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @boats = current_user.boats.page(params[:page]).per(Settings.per_page.boat)
  end

  def show
    @goods = @boat.goods
  end

  def create
    if @boat.save
      flash[:success] = I18n.t("boats.create.success")
      redirect_to boats_path
    else
      flash[:errors] = @boat.errors.full_messages
      redirect_to boats_path
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @boat.save
      flash[:success] = I18n.t("boats.update.success")
      redirect_to boats_path
    else
      flash[:errors] = @boat.errors.full_messages
      redirect_to boats_path
    end
  end

  def destroy
    if @boat.destroy
      flash[:success] = I18n.t("boats.destroy.success")
      redirect_to root_path
    else
      flash[:errors] = @boat.errors.full_messages
      redirect_to boats_path
    end
  end

  private
  def load_instance
    @boat = Boat.find(params[:id])
  end

  def create_instance
    @boat = current_user.boats.new
  end

  def boat_params
    params.require(:boat).permit(:name, :year, :image) if params[:boat]
  end

  def set_params
    @boat.assign_attributes(boat_params)
  end
end
