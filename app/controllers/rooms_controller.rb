class RoomsController < ApplicationController
  def index
    @user = current_user
    if @user.rooms.any?
      @rooms = @user.rooms.all
    else
      @rooms = nil
    end
    destroy_session_room
  end

  def show
    @room = Room.find(params[:id])
    #create_session_room
    @other_user = User.find(@room.other_user_id)
    @user = User.find(current_user.id)
    @messages = Message.where(room_id: @room.id).order(room_id: "DESC")
  end

  def create
    #ユーザがトークでルームを作った場合
    @room = Room.new(room_params)
    @user = current_user
    @other_user = User.find(params[:other_user_id])
    @room.user_id = @user.id
    @room.other_user_id = @other_user.id
    if @room.valid?
      @room.save
      redirect_to root_url
      flash.now[:success] = "トークルームを作成しました"
    else
      redirect_to root_url
    end
    #相手にトークルームが存在しなかった場合
    @confirm_existing_room = Room.find_by(user_id: @other_user.id, other_user_id: @user.id)
    if @confirm_existing_room.nil?
      Room.create!(user_id: @other_user.id , other_user_id: @user.id)
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
  end

  private
    def room_params
      params.permit(:user_id, :other_user_id)
    end
    

end
