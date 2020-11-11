require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'Messageモデルのテスト', type: :test_helper do 
    before do 
      create_user
      @room = Room.create!(user_id: @user.id, other_user_id: @other_user.id)
      @message = Message.new(content: '', room_id: @room.id, user_id: @user.id, other_user_id: @other_user.id)
    end

    it '空の状態では送信できない' do 
      expect(@message.valid?).to eq false
      expect(@message.errors.full_messages).to eq ["Content can't be blank"]
    end

    it 'messageの文字数は140まで' do 
      @message.content = 'a' * 141
      expect(@message.valid?).to eq false
      expect(@message.errors.full_messages).to eq ["Content is too long (maximum is 140 characters)"]
    end

    it '必要な値が入っているか' do 
      @message.content = nil
      @message.room_id = nil
      @message.user_id = nil
      @message.other_user_id = nil
      expect(@message.valid?).to eq false
      expect(@message.errors.full_messages).to eq ["User must exist",
                                                  "Room must exist",
                                                  "Content can't be blank",
                                                  "User can't be blank",
                                                  "Room can't be blank",
                                                  "Other user can't be blank"]
    end


  end
end
