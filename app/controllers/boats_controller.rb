class BoatsController < ApplicationController
  def index
    @boats = current_user.boats.page(params[:page]).per(Settings.per_page.boat)
  end
end
