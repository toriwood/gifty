class UsersController < ApplicationController
  def index
  	@users = User.all
    @gifts = Gift.all
    @following = current_user.following
    @followers = current_user.followers
  end

  def show
    @special_days = user.special_days
  end

  private

  def user
  	@user ||= User.find(params[:id])
  end

  helper_method :user

end
