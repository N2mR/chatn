class MessagesController < ApplicationController


    def show
    end

    # def create
    #     @room = Room.find(params[:room_id])
    #     @user = current_user
    #     @other_user = User.find(@room.other_user_id)
    #     @other_user_room = Room.find_by(user_id: @other_user.id, other_user_id: @user.id)

    #     #　@userのメッセージを作成、セーブする
    #     @message = Message.new(room_id: @room.id, user_id: @user.id, other_user_id: @other_user.id, content: params[:content])

    #     if @message.save
    #         #非同期通信
    #         # respond_to do |format|
    #         #     format.html { redirect_to "room_path(params[:room_id])" }
    #         #     format.js
    #         # end

    #         # @other_userのメッセージを作成、セーブする
    #         if @other_user_room #フレンドのルームを探してメッセージを作成する
    #             @other_user_message = Message.new(room_id: @other_user_room.id, user_id: @other_user.id, 
    #                                               other_user_id: @user.id, content: params[:content])
    #             @other_user_message.save
    #         elsif @other_user_room.nil?　　　　　　　 #フレンドのルームがなければルーム、メッセージを新たに作成する
    #             @create_other_user_room = Room.create!(user_id: @other_user.id , other_user_id: @user.id)
    #             @create_other_user_message = Message.new(room_id: @create_other_user_room.id, user_id: @other_user.id, 
    #                                                      other_user_id: @user.id, content: params[:content])
    #         end

    #         ##ここからaction cableの実装
    #         # ActionCable.server.broadcast 'room_channel', message: @message
    #         # ActionCable.server.broadcast 'room_channel', message: @other_user_message
    #         # ActionCable.server.broadcast 'room_channel', message: @user
    #         # ActionCable.server.broadcast 'room_channel', message: @other_user
    #     end
    # end

    private
        
        def destroy_session_room
            session[:room] = nil
        end
end
