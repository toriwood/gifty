class RelationshipsController < ApplicationController
  def create
  	@relationship = current_user.relationships.build(friend_id: params[:friend_id])
  	current_user.following << params[:friend_id]
  	current_user.save

		if @relationship.save
			flash[:info] = "Followed Successfully."
			redirect_to user_path(params[:friend_id])
		else
			flash[:info] = "Something went wrong."
			redirect_to root_path
		end
	end

	def destroy
		@relationship = current_user.relationships.find(params[:id])

		@relationship.destroy
		flash[:info] = "Successfully unfollowed."
		redirect_to root_path		
	end

	private

	def relationship_params
		params.require(:relationship).permit(:user_id, :friend_id)
	end

end