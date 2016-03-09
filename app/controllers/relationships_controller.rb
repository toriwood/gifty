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
				flash[:info] = "Tagged Successfully."
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
			current_user.save
		flash[:info] = "Successfully unfollowed."

		@relationships.each do |r|
				r.destroy
			end
		else
		@relationship = Relationship.where(friend_id: params[:friend_id], user_id: params[:user_id], category: params[:category])
		friend_id = params[:friend_id]
		
		@relationship.destroy(@relationship)
		flash[:info] = "You're no longer celebrating with #{User.find(friend_id).username}"
		end

		if current_user.celebrating.include?(friend_id.to_s)
			index = current_user.celebrating.index(friend_id.to_s)
			current_user.celebrating.delete_at(index)
			current_user.save
		end

		redirect_to root_path		
	end

	private

	def relationship_params
		params.require(:relationship).permit(:user_id, :friend_id, :category)
	end

end