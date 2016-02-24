class GiftsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  
  def index
  	@gifts = Gift.all
    @interests = Interest.all
  end

  def edit
  	@wishlists = Wishlist.all
  end

  def new
  	@gift = Gift.new
  	@wishlists = Wishlist.all
  end

  def show
  end

  def create
  	@gift = Gift.create(gift_params)
    if @gift.save
      flash[:success] = "The gift was successfully added to the #{@gift.wishlist.name} wishlist."
      redirect_to gifts_path
    else
      @gift.errors.messages.each do |message|
        flash[:error] = message[1][0]
      end
  		redirect_to new_gift_path
  	end
  end

  def update
  	@gift = Gift.update(params[:id], gift_params)

  	if @gift.save
  		flash[:success] = "The gift was successfully updated."
  		redirect_to gift_path
  	else
  		flash[:error] = "There was a problem updating this gift. Try again."
  		redirect_to edit_gift_path
  	end  	
  end

  def destroy
  	gift.destroy
  	flash[:success] = "Gift successfully deleted."
  	redirect_to gifts_path  	
  end

  private

  def gift
  	@gift ||= Gift.find(params[:id])  	
  end

  helper_method :gift

  def gift_params
  	params.require(:gift).permit(:id, :name, :wishlist_id, :url, :description, :image, :user_id)  	
  end

end
