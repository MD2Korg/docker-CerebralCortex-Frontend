require 'test_helper'

class MCerebrumPlatformAppsControllerTest < ActionController::TestCase
  setup do
    @m_cerebrum_platform_app = m_cerebrum_platform_apps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_cerebrum_platform_apps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_cerebrum_platform_app" do
    assert_difference('MCerebrumPlatformApp.count') do
      post :create, m_cerebrum_platform_app: { identifier: @m_cerebrum_platform_app.identifier, platformapptype: @m_cerebrum_platform_app.platformapptype }
    end

    assert_redirected_to m_cerebrum_platform_app_path(assigns(:m_cerebrum_platform_app))
  end

  test "should show m_cerebrum_platform_app" do
    get :show, id: @m_cerebrum_platform_app
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_cerebrum_platform_app
    assert_response :success
  end

  test "should update m_cerebrum_platform_app" do
    patch :update, id: @m_cerebrum_platform_app, m_cerebrum_platform_app: { identifier: @m_cerebrum_platform_app.identifier, platformapptype: @m_cerebrum_platform_app.platformapptype }
    assert_redirected_to m_cerebrum_platform_app_path(assigns(:m_cerebrum_platform_app))
  end

  test "should destroy m_cerebrum_platform_app" do
    assert_difference('MCerebrumPlatformApp.count', -1) do
      delete :destroy, id: @m_cerebrum_platform_app
    end

    assert_redirected_to m_cerebrum_platform_apps_path
  end
end
