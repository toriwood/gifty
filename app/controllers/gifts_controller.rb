class GiftsController < ApplicationController
  require 'metainspector'
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  

  def search
    @q = Gift.ransack(params[:q])
    @gifts = @q.result.includes(:user, :wishlist, :interest)

    @interests = Interest.all

    @holidays = [] 
    days = Holidays.between(Date.new(Time.now.year, 1, 1), Date.new(Time.now.year, 12, 31), :us, :informal)

    days.each do |day|
      @holidays << day[:name]
    end

    @holidays << "Birthday"

  end

  def index
  	if params[:search]
      @gifts = Gift.search(params[:search]).order("created_at DESC")
    else
      @gifts = Gift.all.order('created_at DESC')
    end
    
    @interests = Interest.all
  end

  def edit
  	@wishlists = Wishlist.all

    page = MetaInspector.new(gift.url)
    images = page.images.with_size.take(5)
    @images = []

    images.each do |image|
      @images << image[0]
    end
    
    @images << page.images.best

  @interests = Interest.where('id in (?)', current_user.interests.map { |i| i.to_i })
  end

  def new
    @gift = Gift.new(wishlist_id: params[:format])
    @wishlists = current_user.wishlists

    if @wishlists.empty?
      redirect_to new_wishlist_path
      flash[:danger] = "You must create a wishlist first in order to save your gift."     
    end
  
  @interests = Interest.where('id in (?)', current_user.interests.map { |i| i.to_i })
  end

  def show
  end

  def create
    @gift = Gift.new(gift_params)

    if @gift.save
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
      
      if @gift.url.include?("amazon.com")
        @gift.url += "&#{ENV['amazon_affiliate_key']}"
      end
      redirect_to edit_gift_path(@gift.id)
    else
      @gift.errors.messages.each do |k, v|
        flash[:danger] = "#{k.to_s.titlecase} #{v[0]}."
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
  	params.require(:gift).permit(:id, :name, :wishlist_id, :url, :description, :image, :user_id, :interest_id)  	
  end

end
