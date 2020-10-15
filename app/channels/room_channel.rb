class RoomChannel < ApplicationCable::Channel

  def subscribed
    @user = User.find_by(id: cookies.signed[:user_id])
    if @user
      #ユーザのルームを全て取得
      @rooms = @user.rooms.where(user_id: @user.id)
      #ルームが存在していればルームIDのチャネルを生成
      if @rooms
        @room_array = @rooms.map{ |room| "room_#{room.id}" }
        @room_array.each do |channel_name|
          stream_from "#{channel_name}"
        end
      end
    else
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @room_data = data['data']

    @room_id = @room_data['room_id']
    @user_id = @room_data['current_user_id']
    @other_user_id = @room_data['other_user_id']
    @content = @room_data['message']

    #自分
    @user = User.find(@user_id)
    #相手
    @other_user = User.find(@other_user_id)
    #メッセージを自分のルームに保存
    @message = @user.messages.new(room_id: @room_id ,user_id: @user.id, other_user_id: @other_user.id,
                                          content: @content)
    if @message.save
      #相手に自分とのメッセージルームがあるか確認
      @other_user_room = Room.find_by(user_id: @other_user.id, other_user_id: @user.id)
      if @other_user_room #ルームが存在していればメッセージを保存
        @other_message = Message.new(room_id: @other_user_room.id, user_id: @user.id, other_user_id: @other_user.id, content: @content)
        @other_message.save
        send_message_with_action_cable(@other_message)
      else #無ければ新しくルームを作成してメッセージを保存
        @create_other_user_room = Room.new(user_id: @other_user.id, other_user_id: @user.id)
        @create_other_user_room.save
        @other_message = Message.new(room_id: @create_other_user_room.id, user_id: @user.id , 
                                     other_user_id: @other_user.id , content: @content)
        @other_message.save
        send_message_with_action_cable(@other_message)
      end
      
    else
    end
    
  end

  
  def cookies()
    connection.send(:cookies)
  end
    private

    def send_message_with_action_cable(message)
      ActionCable.server.broadcast "room_#{message.room_id}", message: message.content, created_at: message.created_at
    end

end