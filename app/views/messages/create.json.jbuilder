json.id      @message.id
json.room_id @message.room_id
json.user_id @message.user_id
json.content @message.content 
json.date    @message.created_at.strftime("%Y/%m/%d %H:%M")