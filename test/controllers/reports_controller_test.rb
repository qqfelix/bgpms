require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get team" do
    get :team
    assert_response :success
  end

  test "should get type" do
    get :type
    assert_response :success
  end

end
