class GiftsController < ApplicationController
  def index
  	@gifts = Gift.all
  end

  def new
  	gift = Gift.new
  end

  def show
  end

  private

  def gift
  	Gift.find(params[:id])  	
  end

  helper_method :gift

  def gift_params
  	params.require(:gift).permit(:id, :name, :wishlist_id, :url, :description)  	
  end

end
