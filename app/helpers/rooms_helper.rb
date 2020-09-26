module RoomsHelper
    def get_new_message(room)
        @other_user_id = room.other_user_id
        @messages = room.messages.where(user_id: current_user.id, other_user_id: @other_user_id)
        
        # if @messages
        #     @message = @messages.first
        #     @message.content
        # else
        #     return 'メッセージがありません'
        # end
    end
end