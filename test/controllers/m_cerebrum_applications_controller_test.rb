require 'test_helper'

class MCerebrumApplicationsControllerTest < ActionController::TestCase
  setup do
    @m_cerebrum_application = m_cerebrum_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_cerebrum_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_cerebrum_application" do
    assert_difference('MCerebrumApplication.count') do
      post :create, m_cerebrum_application: { apptype: @m_cerebrum_application.apptype, identifier: @m_cerebrum_application.identifier }
    end

    assert_redirected_to m_cerebrum_application_path(assigns(:m_cerebrum_application))
  end

  test "should show m_cerebrum_application" do
    get :show, id: @m_cerebrum_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_cerebrum_application
    assert_response :success
  end

  test "should update m_cerebrum_application" do
    patch :update, id: @m_cerebrum_application, m_cerebrum_application: { apptype: @m_cerebrum_application.apptype, identifier: @m_cerebrum_application.identifier }
    assert_redirected_to m_cerebrum_application_path(assigns(:m_cerebrum_application))
  end

  test "should destroy m_cerebrum_application" do
    assert_difference('MCerebrumApplication.count', -1) do
      delete :destroy, id: @m_cerebrum_application
    end

    assert_redirected_to m_cerebrum_applications_path
  end
end
