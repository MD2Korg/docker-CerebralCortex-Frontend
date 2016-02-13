require 'test_helper'

class DatastreamsControllerTest < ActionController::TestCase
  setup do
    @datastream = datastreams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:datastreams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create datastream" do
    assert_difference('Datastream.count') do
      post :create, datastream: {  }
    end

    assert_redirected_to datastream_path(assigns(:datastream))
  end

  test "should show datastream" do
    get :show, id: @datastream
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @datastream
    assert_response :success
  end

  test "should update datastream" do
    patch :update, id: @datastream, datastream: {  }
    assert_redirected_to datastream_path(assigns(:datastream))
  end

  test "should destroy datastream" do
    assert_difference('Datastream.count', -1) do
      delete :destroy, id: @datastream
    end

    assert_redirected_to datastreams_path
  end
end
