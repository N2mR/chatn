require 'rails_helper'

RSpec.describe TimelinesController, type: :controller do
	describe 'timeline', type: :test_helper do 
			before do
				before_test
			end

			describe 'index' do 
				it '投稿したタイムラインが表示されているか' do 
					10.times do
						post :create, params: { user_id: @user.id, content: 'Hello, World!' }
					end
					timelines = Timeline.all
					expect(timelines.length).to eq 10
				end
			end

			describe 'create' do
				it '正しく投稿できるか' do 
					post :create, params: { user_id: @user.id, content: 'Hello, World!' }
					timeline = Timeline.last
					expect(timeline.content).to eq 'Hello, World!'
					expect(response).to redirect_to timelines_url
				end

				it '文字制限のバリデーションが機能しているか' do 
					post :create, params: { user_id: @user.id, content: 'a' * 141 }
					timeline = Timeline.last 
					expect(timeline).to eq nil
				end
			end

			describe 'destroy' do 
				it 'タイムラインを削除' do 
					post :create, params: { user_id: @user.id, content: 'Hello, world!' }
					timeline = Timeline.last 
					expect(timeline).to eq timeline
					timeline.destroy
					timeline = Timeline.last
					expect(timeline).to eq nil
				end
			end
	end  

end
