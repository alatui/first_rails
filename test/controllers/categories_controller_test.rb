require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: 'sports')
    @user = User.create(username: 'fernando', email: 'fernando.saxofone@gmail.com', password: '1234', admin: true)
  end

  test 'should get categories index' do
    get :index
    assert_response :success
  end

  test 'should get categories new' do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test 'should get categories show' do
    get :show, params: { id: @category.id }, session: { test: '' }
    assert_response :success
  end

  test 'should redirect create when not admin logged in' do
    assert_no_difference 'Category.count' do
      post :create, params: { category: { name: 'sports'} }
    end
    assert_redirected_to categories_path
  end



end