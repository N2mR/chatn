module TestHelper

  def sample_user
    @user = FactoryBot.create(:user)
  end

  def login_function(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id

    post :create, params: {
          session:{
            email: user.email,
            password: user.password
          }
        }
    expect(response).to redirect_to root_url
  end

  def before_action
    @user =  create(:user)
    session[:user_id] = @user.id
    @other_user = create(:sample1)
  end

end

RSpec.configure do |config|
  config.include TestHelper, type: :test_helper
end