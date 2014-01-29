require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end
  
  test "should not get new" do
    get :new
    #assert_response :success
	assert_redirected_to events_path
  end
  
  test "should not create user" do
    assert_no_difference('User.count') do
      post :create, user: { username: @user.username, email: @user.email, password_hash: @user.password_hash, password_salt: @user.password_salt, admin: @user.admin }
    end
    assert_redirected_to events_path
  end
end
