class GiftsController < ApplicationController
  require 'metainspector'
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  
  def index
  	@gifts = Gift.all
    @interests = Interest.all
  end

  def edit
    @interests = current_user.interests
  	@wishlists = Wishlist.all
    page = MetaInspector.new(gift.url)
    images = page.images.with_size.take(5)
    @images = []

    images.each do |image|
      @images << image[0]
    end
    
    @images << page.images.best
  end

  def new
  	@wishlists = current_user.wishlists

    if @wishlists.empty?
      redirect_to new_wishlist_path
      flash[:danger] = "You must create a wishlist first in order to save your gift."     
    end

    @interests = current_user.interests
    @gift = Gift.new
  end

  def show
  end

  def create
    @gift = Gift.new(gift_params)
    page = MetaInspector.new(gift_params[:url])
    if page.meta_tags['name']['twitter:title'] == nil
        @gift.name = page.title
      else
        @gift.name = page.meta_tags['name']['twitter:title'][0]
      end
      if page.meta_tags['name']['twitter:description'] == nil
        @gift.description = page.description
      else
        @gift.description = page.meta_tags['name']['twitter:description'][0]
      end
    @gift.image_remote_url = page.images.best
    @gift.save

    if @gift.save
      redirect_to edit_gift_path(@gift.id)
    else
      @gift.errors.messages.each do |message|
        flash[:danger] = message[1][0]
      end
      redirect_to new_gift_path
    end
  end

  def update_image
    @new_image = params[:image]
    gift.update_attribute(:image_remote_url, @new_image)
    redirect_to edit_gift_path(@gift)
  end

  def update
  	@gift = Gift.update(params[:id], gift_params)

  	if @gift.save
  		flash[:success] = "The gift information was updated in the #{gift.wishlist.name.titlecase} wishlist."
  		redirect_to @gift
  	else
  		flash[:danger] = "There was a problem updating this gift. Try again."
  		redirect_to edit_gift_path(params[:id])
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
