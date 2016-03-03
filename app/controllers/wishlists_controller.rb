class WishlistsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  
  def index
  	@wishlists = Wishlist.all
  end

  def new
  	@wishlist = Wishlist.new
  end

  def show
    @gifts = Gift.where(wishlist_id: wishlist.id)
  end

  def create
  	@wishlist = Wishlist.create(wishlist_params)

  	if @wishlist.save
  		flash[:success] = "Wishlist created successfully!"
  		redirect_to wishlists_path
  	else
  		flash[:error] = "There was a problem creating this wishlist. Try again."
  		redirect_to new_wishlist_path
  	end
  end

  def update
    @wishlist = Wishlist.update(params[:id], wishlist_params)

    if @wishlist.save
      flash[:success] = "Wishlist updated successfully!"
      redirect_to wishlist_path
    else
      flash[:error] = "There was a problem updating this wishlist. Try again."
      redirect_to edit_wishlist_path
    end
    
  end

  def destroy
    wishlist.destroy
    flash[:success] = "Wishlist deleted successfully."
    redirect_to wishlists_path
  end

private

	def wishlist
		@wishlist ||= Wishlist.find(params[:id])		
	end

	helper_method :wishlist
	
	def wishlist_params
		params.require(:wishlist).permit(:id, :name, :user_id)
	end


end
