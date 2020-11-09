require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe 'rooms', type: :test_helper do 
    before do 
        before_test
    end

    describe 'index' do 
      context '正常に表示されているか' do 
        it 'ルームが０の場合' do 
          get :index 
          expect(response).to have_http_status '200'
          expect(@user.active_relationships).to eq []
          expect(@user.rooms).to eq []
        end

        it 'ルームを新たに作成した場合' do 
          expect(response).to have_http_status '200'
          Room.create!(user_id: @user.id , other_user_id: @other_user.id)
          get :index 
          expect(@user.rooms.count).to eq 1
        end
      end
    end

    describe 'show' do 
      it 'トーク画面に変遷しているかどうか' do 
        @room = Room.create!(user_id: @user.id , other_user_id: @other_user.id)
        get :show , params: { id: @room.id }
        expect(response).to have_http_status '200'
      end
    end

    describe 'create' do 
      context 'メッセージルームを作成する' do 
        it '自分のメッセージルームを作成する' do
            @room = Room.new()
            @room.user_id = @user.id
            @room.other_user_id = @other_user.id
            expect(@room.valid?).to eq true
        end
        it 'ルームを作成した後、相手にルームが存在しなければ作成する' do 
          post :create, params: { other_user_id: @other_user.id }
          expect(@user.rooms.count).to eq 1
          expect(@other_user.rooms.count).to eq 1
        end 
      end  
    end

    describe 'destroy' do 
      it '正常に削除できているかどうか' do 
        @room = Room.create!(user_id: @user.id , other_user_id: @other_user.id)
        expect(Room.all.count).to eq 1
        @room.destroy
        expect(Room.all.count).to eq 0
      end
    end
  end

end
