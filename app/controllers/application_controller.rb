class ApplicationController < ActionController::Base
	helper_method :interests
	helper_method :notifications

	def interests
		@interests = Interest.uniq(:category).take(20)
	end

	def notifications
		events = []
		notifications = []
		users = current_user.celebrating

		users.each do |user|
			User.find(user.to_i).special_days.each do |holiday, day|
			days = {}
				if Date.new(Date.today.year, day.mon, day.mday) > Date.today
					date = Date.new(Date.today.year, day.mon, day.mday)
				else
					date = Date.new(Date.today.year + 1, day.mon, day.mday)
				end

				if date.between?(Date.today, Date.today + 2.week)
					number_of_days = (date - Date.today).to_i
					day = date.strftime("%a, %b #{date.day.ordinalize}")

				days[:user] = user
				days[:holiday] = holiday
				days[:date] = day
				days[:number] = number_of_days

				events << days
				end
			end
		end

		events = events.group_by { |e| e[:holiday] }
		events.each do |k, v|
			usernames = []
			v.each do |vi|
				usernames << User.find(vi[:user]).username.titlecase
			end

			if k.downcase == "birthday"
			notifications << "#{usernames.to_sentence} will be celebrating soon! They'll be celebrating their #{k.downcase} in #{v.first[:number]} days on #{v.first[:date]}."
			else	
			notifications << "#{usernames.to_sentence} will be celebrating soon! They'll be celebrating #{k} in #{v.first[:number]} days on #{v.first[:date]}."
			end
		end

		notifications

	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected 

  def after_sign_in_path_for(resource)
    users_path
  end

end
