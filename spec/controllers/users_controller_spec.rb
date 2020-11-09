require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
	describe 'UsersControllerのテスト', type: :test_helper do
    before do 
      before_test
    end

    context "index" do
      it 'ルートURLに移動する' do
        get :index
        expect(response).to have_http_status '200'
      end
    end
    
    describe 'create' do 
      context 'ユーザー登録のバリデーション' do 
        it 'ユーザーを正しく作成する' do 
          get :new
          expect(response).to have_http_status '200'
          @user = User.new(name: 'sample1', email: 'sample1@sample.com', password: 'password',
                           password_confirmation: 'password', search_id: 'sample1')
          expect(@user.valid?).to eq true
        end
        
        it 'emailのフォーマット' do 
          @user.email = 'hogehoge'
          expect(@user.valid?).to eq false
          expect(@user.errors.full_messages).to eq ["Email is invalid"]
        end

        it 'passwordの文字数' do 
          @user.password = 'aaaaaaaaaaa' * 5
          @user.password_confirmation = 'aaaaaaaaaaa' * 5
          expect(@user.valid?).to eq false
          expect(@user.errors.full_messages).to eq ["Password is too long (maximum is 50 characters)"]
        end

        it 'passwordが確認と一致しない場合' do 
          @user.password_confirmation = 'hogehoge'
          expect(@user.valid?).to eq false
          expect(@user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
        end

        it 'search_idの文字数は11文字以下' do 
          @user.search_id = 'aaaaaaaaaaaa'
          expect(@user.valid?).to eq false
          expect(@user.errors.full_messages).to eq ["Search is too long (maximum is 11 characters)"]
        end
        
        
      end
    end 
  end

end
