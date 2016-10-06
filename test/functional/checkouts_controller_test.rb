require 'test_helper'

class CheckoutsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checkouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checkout" do
    assert_difference('Checkout.count') do
      post :create, :checkout => { }
    end

    assert_redirected_to checkout_path(assigns(:checkout))
  end

  test "should show checkout" do
    get :show, :id => checkouts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => checkouts(:one).to_param
    assert_response :success
  end

  test "should update checkout" do
    put :update, :id => checkouts(:one).to_param, :checkout => { }
    assert_redirected_to checkout_path(assigns(:checkout))
  end

  test "should destroy checkout" do
    assert_difference('Checkout.count', -1) do
      delete :destroy, :id => checkouts(:one).to_param
    end

    assert_redirected_to checkouts_path
  end
end
