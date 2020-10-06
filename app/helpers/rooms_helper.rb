module RoomsHelper
    def get_newest_message(room)
        @message = room.messages.last
        if @message
            
            if @message.user_id == current_user.id
                return "あなた: #{@message.content}"
            else
                @other_user = User.find(@message.user_id)
                return "#{@other_user.name}: #{@message.content}"
            end
        else
            'メッセージがありません'
        end
    end
end