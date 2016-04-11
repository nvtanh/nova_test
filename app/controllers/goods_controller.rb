class GoodsController < ApplicationController
  before_action :load_boat
  before_action :load_instance, only: [:edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def create
    if @good.save
      flash[:success] = I18n.t("boats.create.success")
      redirect_to boat_path(@boat)
    else
      flash[:errors] = @good.errors.full_messages
      render :new
    end
  end

  def new
  end

  def edit
  end

  def update
    if @good.save
      flash[:success] = I18n.t("goods.update.success")
      redirect_to boat_path(@boat)
    else
      flash[:errors] = @good.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @good.destroy
      flash[:success] = I18n.t("goods.destroy.success")
      redirect_to boat_path(@boat)
    else
      flash[:errors] = @good.errors.full_messages
      redirect_to boat_path(@boat)
    end
  end

  private
  def load_boat
    @boat = Boat.find(params[:boat_id])
  end

  def load_instance
    @good = Good.find(params[:id])
  end

  def create_instance
    @good = @boat.goods.new
  end

  def good_params
    params.require(:good).permit(:name, :quantity) if params[:good]
  end

  def set_params
    @good.assign_attributes(good_params)
  end
end
