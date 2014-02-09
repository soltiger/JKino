# encoding: utf-8
require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
	@fake_user_name = "fake_username"
	@fake_user_passowrd = "fake_password"
    @test_user_name = "test_user"
    @test_user_password = "test_user_123"
    @test_admin_name = "test_admin"
    @test_admin_password = "test_admin_123"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should not login" do
    get :new
    post :create, { username: @fake_user_name, password: @fake_user_passowrd }
    assert_response :success
	assert_equal 'Väärä käyttäjänimi tai salasana', flash[:alert]
  end

  test "should login, normal user" do
    get :new
    post :create, { username: @test_user_name, password: @test_user_password }
	assert_redirected_to root_url
	assert_equal 'Kirjautuminen onnistui', flash[:notice]
  end

  test "should login & logout, normal user" do
    get :new
    post :create, { username: @test_user_name, password: @test_user_password }
	assert_redirected_to root_url
	assert_equal 'Kirjautuminen onnistui', flash[:notice]
	
    get :destroy
	assert_redirected_to root_url
	assert_equal 'Kirjauduit ulos', flash[:notice]
  end
 
  test "should login, admin user" do
    get :new
    post :create, { username: @test_admin_name, password: @test_admin_password }
	assert_redirected_to root_url
	assert_equal 'Kirjautuminen onnistui', flash[:notice]
  end

  test "should login & logout, admin user" do
    get :new
    post :create, { username: @test_admin_name, password: @test_admin_password }
	assert_redirected_to root_url
    delete :destroy
	assert_redirected_to root_url
	assert_equal 'Kirjauduit ulos', flash[:notice]
  end
  
end