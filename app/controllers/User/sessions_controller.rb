class User::SessionsController < Devise::SessionsController
  def index
    @users = User.all
  end

  def show

  end

  private

  def user
    @user ||= User.find(params[:id])    
  end

  helper_method :user
end
