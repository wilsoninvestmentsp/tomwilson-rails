require 'test_helper'

class JassetsControllerTest < ActionController::TestCase
  setup do
    @jasset = jassets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jassets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jasset" do
    assert_difference('Jasset.count') do
      post :create, jasset: { description: @jasset.description, image: @jasset.image, link_name: @jasset.link_name, link_uri: @jasset.link_uri, sort: @jasset.sort, title: @jasset.title }
    end

    assert_redirected_to jasset_path(assigns(:jasset))
  end

  test "should show jasset" do
    get :show, id: @jasset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jasset
    assert_response :success
  end

  test "should update jasset" do
    patch :update, id: @jasset, jasset: { description: @jasset.description, image: @jasset.image, link_name: @jasset.link_name, link_uri: @jasset.link_uri, sort: @jasset.sort, title: @jasset.title }
    assert_redirected_to jasset_path(assigns(:jasset))
  end

  test "should destroy jasset" do
    assert_difference('Jasset.count', -1) do
      delete :destroy, id: @jasset
    end

    assert_redirected_to jassets_path
  end
end
