require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should not get new" do
    get :new
	assert_redirected_to movies_path
  end

  test "should not create movie" do
    assert_no_difference('Movie.count') do
      post :create, movie: { movie_name: @movie.movie_name, movie_url: @movie.movie_url }
    end

	assert_redirected_to movies_path
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end

  test "should not get edit" do
    get :edit, id: @movie
	assert_redirected_to movies_path
  end

  test "should not update movie" do
    patch :update, id: @movie, movie: { movie_name: @movie.movie_name, movie_url: @movie.movie_url }
	assert_redirected_to movies_path
  end

  test "should not destroy movie" do
    assert_no_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

	assert_redirected_to movies_path
  end
end
