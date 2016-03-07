class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  helper_method :interests

  def interests
    @interests = Interest.all
  end

  def create
    super do 
      @user.special_days[:birthday] = @user.birthday
      @user.save
    end
  end

  def update
    super do 
      @user.special_days[:birthday] = @user.birthday
      @user.save
    end
  end


  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:image, :age, :gender, :name, :username, :birthday,
        :email, :password, :password_confirmation, :interests, :following, :special_days)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:image, :age, :gender, :name, :username, :birthday,
        :email, :password, :password_confirmation, :current_password, :interests, :following, :special_days)
    end
  end
end