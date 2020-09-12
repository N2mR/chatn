class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    current_user.be_a_friend(@user)
    redirect_to root_url
  end

  def destroy
    @user = Relationship.find(params[:followed_id]).followed
    current_user.remove_my_friend(@user)
  end
end
