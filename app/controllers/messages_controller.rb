class MessagesController < ApplicationController
    
    def show
    end

    def create

        @room = Room.find(params[:room_id])
        @user = current_user
        @other_user = User.find(@room.other_user_id)
        @other_user_room = Room.find_by(user_id: @other_user.id, other_user_id: @user.id)

        #　@userのメッセージを作成、セーブする
        @message = Message.new(room_id: @room.id, user_id: @user.id, content: params[:content])

        if @message.valid?
            @message.save
            # @other_userのメッセージを作成、セーブする
            @other_user_message = Message.new(room_id: @other_user_room.id, user_id: @user.id, content: params[:content])
            @other_user_message.save
            respond_to do |format|
                format.html { redirect_to "room_path(#{@room.id})" }
                format.json
            end
            ##ここからaction cableの実装
            # ActionCable.server.broadcast 'room_channel', message: @message
            # ActionCable.server.broadcast 'room_channel', message: @other_user_message
            # ActionCable.server.broadcast 'room_channel', message: @user
            # ActionCable.server.broadcast 'room_channel', message: @other_user
        end
    end

    private
        
        def destroy_session_room
            session[:room] = nil
        end
end
