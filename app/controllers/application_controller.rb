class ApplicationController < ActionController::Base
	helper_method :interests
	helper_method :notifications

	def interests
		@interests = Interest.uniq(:category).take(20)
	end

	def notifications
		@notifications = []
		users = current_user.celebrating

		users.each do |user|
			User.find(user.to_i).special_days.each do |holiday, day|
			day_array = []
				if Date.new(Date.today.year, day.mon, day.mday) > Date.today
					date = Date.new(Date.today.year, day.mon, day.mday)
				else
					date = Date.new(Date.today.year + 1, day.mon, day.mday)
				end

				if date.between?(Date.today, Date.today + 1.week)
					number_of_days = (date - Date.today).to_i
					day = date.strftime("%a, %b #{date.day.ordinalize}")
				day_array << number_of_days
				day_array << {holiday => day}	
				@notifications << [user, day_array]
				end
			end
		end

		@notifications.sort_by { |n| n[1][1].values.first }
			
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
