class InterestsController < ApplicationController
  def index
  	@interests = Interest.order('category ASC').order('subcategory ASC').order('name ASC')
  end

  def show
    @gifts= Gift.where(interest_id: params[:id])
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
