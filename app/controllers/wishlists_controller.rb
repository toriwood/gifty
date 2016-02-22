class WishlistsController < ApplicationController
  def index
  	@wishlists = Wishlist.all
  end

  def new
  	@wishlist = Wishlist.new
  end

  def show
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


private

	def wishlist
		@wishlist = Wishlist.find(params[:id])		
	end

	helper_method :wishlist
	
	def wishlist_params
		params.require(:wishlist).permit(:id, :name)
	end


end
