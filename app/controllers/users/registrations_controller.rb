class Users::RegistrationsController < Devise::RegistrationsController
  require 'holidays/core_extensions/date'
  
  before_filter :configure_permitted_parameters

  helper_method :interests
  helper_method :holidays

  def interests
    @interests = Interest.order('category ASC').order('subcategory ASC').order('name ASC')
  end

  def holidays
    @holidays = Holidays.between(Date.new(Time.now.year, 1, 1), Date.new(Time.now.year, 12, 31), :us, :informal)
  end
  
  def create
    super do
    if !params[:user][:special_days].nil?
      params[:user][:special_days].each do |day|
        day = day.split(":")
        @user.special_days[day[0].to_s] = day[1].to_date
      end
    end

      @user.special_days["Birthday"] = @user.birthday
      @user.save
    end
  end

  def update
    super do
    if !params[:user][:special_days].nil?
      @user.special_days.clear
      params[:user][:special_days].each do |day|
        day = day.split(":")
        @user.special_days[day[0].to_s] = day[1].to_date
      end
    end

      @user.special_days["Birthday"] = @user.birthday
      @user.save
    end

    sign_in(@user, :bypass => true)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:image, :age, :gender, :name, :username, :birthday,
        :email, :password, :password_confirmation, {:interests => []},
        :following, :special_days, :celebrating)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:image, :age, :gender, :name, :username, :birthday,
        :email, :password, :password_confirmation, :current_password, 
        {:interests => []}, :following, :special_days, :celebrating)
    end
  end
end