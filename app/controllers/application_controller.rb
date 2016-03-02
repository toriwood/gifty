class ApplicationController < ActionController::Base
 
	helper_method :interests

	def interests
		@interests = Interest.uniq(:category).take(20)
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
