# encoding: utf-8

require 'test_helper'

class AdminUserFlowsTest < ActionDispatch::IntegrationTest
	fixtures :events
	fixtures :movies
	fixtures :users

	setup do
		login_admin
	end
	
	def teardown
		logout
	end
	
	#
	# CREATE EVENT
	#
	test "should create event" do
		create_event
	end	
	
	test "should not create event without time" do
		get new_event_path
		assert_response :success
		
		assert_no_difference('Event.count') do
			post_via_redirect events_path, event: { event_date: "" }
		end

		assert_equal events_path, path
	end	
	
	test "should not create event with wrong time format" do
		get new_event_path
		assert_response :success
		
		assert_no_difference('Event.count') do
			post_via_redirect events_path, event: { event_date: "32-01-2014" }
		end

		assert_equal events_path, path
	end	

	#
	# UPDATE EVENT
	#
	test "should not update event without time" do
		create_event
		@latest_event = Event.order("created_at").last
		
		get edit_event_path(@latest_event)
		assert_response :success
		
		assert_no_difference('Event.count') do
			patch_via_redirect event_path(@latest_event), event: { event_date: "", event_name: @latest_event.event_name, participantCount: @latest_event.participantCount }
		end

		assert_equal event_path(@latest_event), path
	end	

	test "should not update event with wrong time format" do
		create_event
		@latest_event = Event.order("created_at").last
		
		get edit_event_path(@latest_event)
		assert_response :success
		
		assert_no_difference('Event.count') do
			patch_via_redirect event_path(@latest_event), event: { event_date: "32-01-2014", event_name: @latest_event.event_name, participantCount: @latest_event.participantCount }
		end

		assert_equal event_path(@latest_event), path
	end	

	test "should update event" do
		create_event
		@latest_event = Event.order("created_at").last
		@old_participantCount = @latest_event.participantCount

		get edit_event_path(@latest_event)
		assert_response :success
		
		assert_no_difference('Event.count') do
			put_via_redirect event_path(@latest_event), event: { event_date: "14-01-2014", event_name: "Updated name", participantCount: @old_participantCount + 1 }
		end

		@latest_event = Event.find( @latest_event.id )

		assert_equal "2014-01-14", @latest_event.event_date.to_s(:db)
		assert_equal "Updated name", @latest_event.event_name
		assert_equal @old_participantCount + 1, @latest_event.participantCount

		assert_equal events_path, path
		assert_equal 'Esitys päivitetty', flash[:notice]
	end	

	#
	# DESTROY EVENT
	#
	test "should destroy event" do
		create_event
		@latest_event = Event.order("created_at").last
	
		assert_difference('Event.count', -1) do
			delete_via_redirect event_path(@latest_event), id: @latest_event
		end

		assert_equal false, Event.exists?( @latest_event )
		assert_equal events_path, path
		assert_equal 'Esitys poistettu', flash[:notice]
	end	

	#
	# CREATE MOVIE
	#
	test "should create movie" do
		create_movie
	end	
	
	test "should not create movie without name" do
		get new_movie_path
		assert_response :success
		
		assert_no_difference('Movie.count') do
			post_via_redirect movies_path, movie: { movie_name: "" }
		end

		assert_equal movies_path, path
	end	

	#
	# UPDATE MOVIE
	#
	test "should not update movie without name" do
		create_movie
		@latest_movie = Movie.order("created_at").last
		
		get edit_movie_path(@latest_movie)
		assert_response :success
		
		assert_no_difference('Movie.count') do
			patch_via_redirect movie_path(@latest_movie), movie: { movie_name: "", movie_url: @latest_movie.movie_url }
		end

		assert_equal movie_path(@latest_movie), path
	end	

	test "should update movie" do
		create_movie
		@latest_movie = Movie.order("created_at").last

		get edit_movie_path(@latest_movie)
		assert_response :success
		
		assert_no_difference('Movie.count') do
			put_via_redirect movie_path(@latest_movie), movie: { movie_name: "Updated movie", movie_url: "http://wikipedia.fi" }
		end

		@latest_movie = Movie.find( @latest_movie.id )

		assert_equal "Updated movie", @latest_movie.movie_name
		assert_equal "http://wikipedia.fi", @latest_movie.movie_url

		assert_equal movies_path, path
		assert_equal 'Elokuva päivitetty', flash[:notice]
	end	

	#
	# DESTROY MOVIE
	#
	test "should destroy movie" do
		create_movie
		@latest_movie = Movie.order("created_at").last
	
		assert_difference('Movie.count', -1) do
			delete_via_redirect movie_path(@latest_movie), id: @latest_movie
		end

		assert_equal false, Movie.exists?( @latest_movie )
		assert_equal movies_path, path
		assert_equal 'Elokuva poistettu', flash[:notice]
	end	

	#
	# CREATE USER
	#
	test "should create user" do
		create_user("new_test_user")
	end	
	
	test "should not create user without username" do
		get new_user_path
		assert_response :success
		
		assert_no_difference('User.count') do
			post_via_redirect users_path, user: { username: "", email: "new_email@email.com", password: "secret", password_confirmation: "secret" }
		end

		assert_equal users_path, path
	end	

	test "should not create user without password" do
		get new_user_path
		assert_response :success
		
		assert_no_difference('User.count') do
			post_via_redirect users_path, user: { username: "new_test_user_2", email: "new_email@email.com", password: "", password_confirmation: "" }
		end

		assert_equal users_path, path
	end	

	test "should not create user with not matching passwords" do
		get new_user_path
		assert_response :success
		
		assert_no_difference('User.count') do
			post_via_redirect users_path, user: { username: "new_test_user_2", email: "new_email@email.com", password: "secret", password_confirmation: "" }
		end

		assert_equal users_path, path
	end	

	test "should not create user with same username" do
		create_user("new_test_user_2")
		
		assert_no_difference('User.count') do
			post_via_redirect users_path, user: { username: "new_test_user_2", email: "new_email@email.com", password: "secret", password_confirmation: "secret" }
		end

		assert_equal users_path, path
	end	
	
	#
	# PRIVATE
	#
	private 
	def login_admin
		@test_admin_name = "test_admin"
		@test_admin_password = "test_admin_123"
		
		get "/log_in"
		assert_response :success
		
		post_via_redirect sessions_path, username: @test_admin_name, password: @test_admin_password
		assert_equal root_path, path
		assert_equal 'Kirjautuminen onnistui', flash[:notice]
	end
	
	def logout
		get "/log_out"
		assert_redirected_to root_url
		assert_equal 'Kirjauduit ulos', flash[:notice]
	end
	
	def create_event
		get new_event_path
		assert_response :success
		
		assert_difference('Event.count', 1) do
			post_via_redirect "/events", event: { event_date: "09-01-2014", event_name: "Test event", participantCount: 5  }
		end

		@latest_event = Event.order("created_at").last
		
		assert_equal "2014-01-09", @latest_event.event_date.to_s(:db)
		assert_equal "Test event", @latest_event.event_name
		assert_equal 5, @latest_event.participantCount

		assert_equal events_path, path
		assert_equal 'Esitys luotu', flash[:notice]
	end
	
	def create_movie
		get new_movie_path
		assert_response :success
		
		assert_difference('Movie.count', 1) do
			post_via_redirect movies_path, movie: { movie_name: "test movie", movie_url: "http://imdb.com" }
		end

		@latest_movie = Movie.order("created_at").last
		
		assert_equal "test movie", @latest_movie.movie_name
		assert_equal "http://imdb.com", @latest_movie.movie_url

		assert_equal movies_path, path
		assert_equal 'Elokuva lisätty', flash[:notice]
	end

	def create_user(username)
		get new_user_path
		assert_response :success
		
		assert_difference('User.count', 1) do
			post_via_redirect users_path, user: { username: username, email: "new_email@email.com", password: "secret", password_confirmation: "secret" }
		end

		@latest_user = User.order("created_at").last
		
		assert_equal username, @latest_user.username
		assert_equal "new_email@email.com", @latest_user.email

		assert_equal root_path, path
		assert_equal 'Käyttäjä luotu', flash[:notice]
		
		logout

		get "/log_in"
		assert_response :success
		
		post_via_redirect sessions_path, username: username, password: "secret"
		assert_equal root_path, path
		assert_equal 'Kirjautuminen onnistui', flash[:notice]

		logout
		login_admin
	end
end
