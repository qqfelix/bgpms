require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get week" do
    get :week
    assert_response :success
  end

  test "should get month" do
    get :month
    assert_response :success
  end

end
