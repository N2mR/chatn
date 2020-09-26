class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    current_user.be_a_friend(@user)
    redirect_to root_url
  end

  def destroy
    @relationship = current_user.active_relationships.find_by(followed_id: params[:id])
    current_user.remove_my_friend(@relationship)
   end
end
