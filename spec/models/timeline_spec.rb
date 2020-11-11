require 'rails_helper'

RSpec.describe Timeline, type: :model do
  describe 'Timelineモデルのテスト', type: :test_helper do 
		before do 
			create_user
			@timeline = Timeline.new
		end

		it 'timelineは140字以内' do 
			@timeline.user_id = @user.id
			@timeline.content = 'a' * 141
			expect(@timeline.valid?).to eq false
			expect(@timeline.errors.full_messages).to eq ["Content is too long (maximum is 140 characters)"]
		end

		it '空のタイムラインは投稿できない' do 
			@timeline.user_id = @user.id
			expect(@timeline.valid?).to eq false
			expect(@timeline.errors.full_messages).to eq ["Content can't be blank"]
		end 

		it '必要な値が入っているかどうか' do 
			expect(@timeline.valid?).to eq false
			expect(@timeline.errors.full_messages).to eq ["User must exist", "Content can't be blank"]
		end
	end
end
