class RelationshipsController < ApplicationController
  def create
  	@relationship = current_user.relationships.build(friend_id: params[:friend_id], category: params[:category])

  	if params[:category] == "follow"
	  	!current_user.following.include?(params[:friend_id]) ? current_user.following << params[:friend_id] : current_user.following
	  	current_user.save
	  elsif params[:category] == "celebrate"

	  	!current_user.celebrating.include?(params[:friend_id]) ? current_user.celebrating << params[:friend_id] : current_user.celebrating
	  	current_user.save
	  end

		if @relationship.save
			if params[:category] == "follow"
				flash[:info] = "Followed Successfully."
			else
				flash[:info] = "You're celebrating with #{User.find(params[:friend_id]).username} now! You'll receive status updates when they have a favorite holiday or special occasion coming up."
			end
			redirect_to user_path(params[:friend_id])
		else
			flash[:info] = "Something went wrong."
			redirect_to root_path
		end
	end

	def destroy
		if params[:category].nil?

			@relationships = Relationship.where(friend_id: params[:friend_id], user_id: params[:user_id])

			index = current_user.following.index(params[:friend_id].to_s)
			current_user.following.delete_at(index)

			@relationships.each do |r|
				r.destroy
			end

			if current_user.celebrating.include?(params[:friend_id].to_s)
			index = current_user.celebrating.index(params[:friend_id].to_s)
			current_user.celebrating.delete_at(index)
			current_user.save
		end

			current_user.save
		flash[:info] = "Successfully unfollowed."

		else
		@relationship = Relationship.where(friend_id: params[:friend_id], user_id: params[:user_id], category: params[:category])
		friend_id = params[:friend_id]

		@relationship.destroy(@relationship)
		index = current_user.celebrating.index(params[:friend_id].to_s)
		current_user.celebrating.delete_at(index)
		current_user.save
		flash[:info] = "Bummer. You're no longer celebrating with #{User.find(friend_id).username}."
		end

		

		redirect_to root_path		
	end

	private

	def relationship_params
		params.require(:relationship).permit(:user_id, :friend_id, :category)
	end

end