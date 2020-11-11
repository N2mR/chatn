require 'rails_helper'

RSpec.describe Room, type: :model do
	describe 'Roomモデルのテスト', type: :test_helper do
		
		before do 
			create_user
			@room = Room.new(user_id: '', other_user_id: '')
		end

		it '必要な値が入っているか' do 
			expect(@room.valid?).to eq false
			expect(@room.errors.full_messages).to eq ["User must exist", "User can't be blank", "Other user can't be blank"]
		end

	end
end
