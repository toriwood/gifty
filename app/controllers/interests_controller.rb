class InterestsController < ApplicationController
  def index
  	@interests = Interest.all
  end

  def show
  end


  private

  def interest
  	@interest ||= Interest.find(params[:id])
  end

  def interest_params
  	params.require(:interest).permit(:id, :name, :subcategory, :category)
  end
end
