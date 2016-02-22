class WishlistsController < ApplicationController
  def index
  	@wishlists = Wishlist.all
  end

  def new
  	@wishlist = Wishlist.new
  end

  def edit
    @wishlist = wishlist
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

  def update
    @wishlist = Wishlist.update(params[:id], wishlist_params)

    if @wishlist.save
      flash[:success] = "Wishlist updated successfully!"
      redirect_to wishlist_path
    else
      flash[:error] = "There was a problme updating this wishlist. Try again."
      redirect_to edit_wishlist_path
    end
    
  end

  def destroy
    wishlist.destroy
    redirect_to wishlists_path
  end

private

	def wishlist
		wishlist = Wishlist.find(params[:id])		
	end

	helper_method :wishlist
	
	def wishlist_params
		params.require(:wishlist).permit(:id, :name)
	end


end
