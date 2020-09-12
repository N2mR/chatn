require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def  setup
    @user = users(:ayumu)
  end

  test 'ログイン機能' do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }

    assert_redirected_to root_url
  end
end
