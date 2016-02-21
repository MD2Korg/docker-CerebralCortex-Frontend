require 'test_helper'

class MCerebrumPlatformsControllerTest < ActionController::TestCase
  setup do
    @m_cerebrum_platform = m_cerebrum_platforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_cerebrum_platforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_cerebrum_platform" do
    assert_difference('MCerebrumPlatform.count') do
      post :create, m_cerebrum_platform: { identifier: @m_cerebrum_platform.identifier, platformtype: @m_cerebrum_platform.platformtype }
    end

    assert_redirected_to m_cerebrum_platform_path(assigns(:m_cerebrum_platform))
  end

  test "should show m_cerebrum_platform" do
    get :show, id: @m_cerebrum_platform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_cerebrum_platform
    assert_response :success
  end

  test "should update m_cerebrum_platform" do
    patch :update, id: @m_cerebrum_platform, m_cerebrum_platform: { identifier: @m_cerebrum_platform.identifier, platformtype: @m_cerebrum_platform.platformtype }
    assert_redirected_to m_cerebrum_platform_path(assigns(:m_cerebrum_platform))
  end

  test "should destroy m_cerebrum_platform" do
    assert_difference('MCerebrumPlatform.count', -1) do
      delete :destroy, id: @m_cerebrum_platform
    end

    assert_redirected_to m_cerebrum_platforms_path
  end
end
