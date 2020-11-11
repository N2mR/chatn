require 'rails_helper'

RSpec.describe User, type: :model do
	describe 'userモデルのテスト', type: :test_helper do 
		before do
			@user = create(:user)
		end
    context 'emailのバリデーション' do 
			it 'emailは２２５文字以内' do 
				@user.email = 'a' * 215 + '@sample.com'
				expect(@user.valid?).to eq false
				expect(@user.errors.full_messages).to eq ["Email is too long (maximum is 225 characters)"]
			end

			it 'emailのフォーマットが適切かどうか' do 
				@user.email = 'aaaaaaaaaa'
				expect(@user.valid?).to eq false
				expect(@user.errors.full_messages).to eq ["Email is invalid"]
			end
		end
		
		context 'passwordのバリデーション' do 
			it 'passwordは８文字以上' do 
				@user.password = 'a' * 6
				@user.password_confirmation = 'a' * 6
				expect(@user.valid?).to eq false
				expect(@user.errors.full_messages).to eq ["Password is too short (minimum is 8 characters)"]
			end

			it 'passwordは50文字以下' do 
				@user.password = 'a' * 51
				@user.password_confirmation = 'a' * 51
				expect(@user.valid?).to eq false
				expect(@user.errors.full_messages).to eq ["Password is too long (maximum is 50 characters)"]
			end

			it 'passwordとconfirmが一致しているかどうか' do 
				@user.password = 'hogehoge'
				expect(@user.valid?).to eq false
				expect(@user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
			end
		end

		context 'search_idのバリデーション' do 
			it 'search_id' do 
				@user.search_id = 'aaa'
				expect(@user.valid?).to eq false
				expect(@user.errors.full_messages).to eq ["Search is too short (minimum is 4 characters)"]
			end

			it 'search_idは11文字以下' do 
				@user.search_id = 'a' * 12
				expect(@user.valid?).to eq false
				expect(@user.errors.full_messages).to eq ["Search is too long (maximum is 11 characters)"]
			end
		end
		
		context '重複したデータ' do 
			it 'データが一意であるかどうか' do 
				@user2 = User.new(name: 'sample', email: 'sample@sample.com', password: 'password',
													password_confirmation: 'password', search_id: 'sample')
				expect(@user2.valid?).to eq false
				expect(@user2.errors.full_messages).to eq ["Email has already been taken", "Search has already been taken"]
			end
		end
  end
end
