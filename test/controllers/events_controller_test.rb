require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:event_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should not get new" do
    get :new
    #assert_response :success
    assert_redirected_to events_path
  end

  # Normal user should not be allowed to create an event
  test "should not create event" do
    assert_no_difference('Event.count') do
      post :create, event: { event_date: @event.event_date, event_name: @event.event_name, participantCount: @event.participantCount }
    end
    assert_redirected_to events_path
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should not get edit" do
    get :edit, id: @event
    #assert_response :success
    assert_redirected_to events_path
  end

  test "should not update event" do
    patch :update, id: @event, event: { event_date: @event.event_date, event_name: @event.event_name }
    #assert_redirected_to event_path(assigns(:event))
    assert_redirected_to events_path
  end

  test "should not destroy event" do
    assert_no_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    #assert_redirected_to events_path
    assert_redirected_to events_path
  end
end