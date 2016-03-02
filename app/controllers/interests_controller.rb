class InterestsController < ApplicationController
  def index
  	@interests = Interest.all
  end

  def show
    @gifts = Gift.where(interest_id: interest.id)
  end


  private

  def interest
  	@interest ||= Interest.find(params[:id])
  end

  helper_method :interest

  def interest_params
  	params.require(:interest).permit(:id, :name, :subcategory, :category)
  end
end
