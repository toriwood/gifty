class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  helper_method :interests

  def interests
    @interests = Interest.all
  end

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:image, :age, :gender, :name, :username, :birthday,
        :email, :password, :password_confirmation, {:interests => []}, :following)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:image, :age, :gender, :name, :username, :birthday,
        :email, :password, :password_confirmation, :current_password, {:interests => []}, :following)
    end
  end
end