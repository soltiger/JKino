require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @test_admin = users(:test_admin)
    @test_user = users(:test_user)
  end
  
  test "should not get new" do
    get :new
    #assert_response :success
	assert_redirected_to events_path
  end
  
  test "should not create user" do
    assert_no_difference('User.count') do
      post :create, user: { username: "new_user", email: "new_email@email.com", password_confirmation: "new_password" }
    end
    assert_redirected_to events_path
  end
end
