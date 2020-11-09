require 'rails_helper'
include ApplicationHelper

RSpec.describe SessionsController, type: :controller do
  describe 'sessions_controllerのテスト', type: :test_helper do 

    before 'ユーザーをログインする' do
      @user = sample_user 
      login_function(@user)
    end

    describe 'create' do 
      it 'ログインする' do 
        login_function(@user)
      end

      it 'アドレスとパスワードが一致しない場合login_pathにリダイレクト' do
        post :create, params:{
          session:{
            email: @user.email,
            password: 'hogehoge'
          }
        }
        expect(response).to redirect_to login_url
      end
    end
  end
end
