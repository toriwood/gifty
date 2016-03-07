class RelationshipsController < ApplicationController
  def create
  	@relationship = current_user.relationships.build(friend_id: params[:friend_id])

		if @relationship.save
			flash[:notice] = "Followed Successfully."
			redirect_to user_path(params[:friend_id])
		else
			flash[:notice] = "Something went wrong."
			redirect_to root_path
		end
	end

	def destroy
		@relationship = current_user.relationships.find(params[:id])

		@relationship.destroy
		flash[:notice] = "Successfully unfollowed."
		redirect_to root_path		
	end

	private

	def relationship_params
		params.require(:relationship).permit(:user_id, :friend_id)
	end

end