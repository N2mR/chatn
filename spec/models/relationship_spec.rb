require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'Relationshipモデルのテスト', type: :test_helper do 
		before do 
			create_user
			@relation_ship = Relationship.new()
		end

		it '必要な値が入っているか' do 
			expect(@relation_ship.valid?).to eq false
			expect(@relation_ship.errors.full_messages).to eq ["Follower must exist",
																												"Followed must exist",
																												"Follower can't be blank",
																												"Followed can't be blank"]
		end
	end
end
