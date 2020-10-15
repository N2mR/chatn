require 'test_helper'

class TimelinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get timelines_index_url
    assert_response :success
  end

  test "should get create" do
    get timelines_create_url
    assert_response :success
  end

  test "should get destroy" do
    get timelines_destroy_url
    assert_response :success
  end

end
