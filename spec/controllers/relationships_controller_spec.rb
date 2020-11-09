require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe 'RelationshipsControllerのテスト', type: :test_helper do 
    before do 
      before_test
    end

    describe 'create' do 
      context 'relationships' do 
        it '@userが@sample_userを追加する' do 
          expect(@user.following).to eq []
          expect(@other_user.follower).to eq []
          @user.be_a_friend(@other_user)
          expect(@user.following.find_by(id: @other_user.id)).to eq @other_user
          expect(@other_user.follower.find_by(id: @user.id)).to eq @user
        end
      end
    end

    describe 'destroy' do 
      context 'relationships' do 
        it '@userが@sample_userをフレンドから削除する' do 
          #フレンドに追加する
          @user.be_a_friend(@other_user)
          expect(@user.following.find_by(id: @other_user.id)).to eq @other_user
          #フレンドから削除する
          @relationship = @user.active_relationships.find_by(followed_id: @other_user)
          @user.remove_my_friend(@relationship)
          expect(@user.following.find_by(id: @other_user.id)).to eq nil
        end
      end
    end
  end
end