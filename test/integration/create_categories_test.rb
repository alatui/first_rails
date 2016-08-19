require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = { username: 'fernando', email: 'fernando.saxofone@gmail.com', password: '1234', admin: true }
    @current_user = User.create(@user)
  end

  test 'get new category form and create category' do
    login
    get new_category_path
    #follow_redirect!
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: 'sports' } }
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  test 'create category without name' do
    login
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: '' } }
    end
    assert_template 'categories/new'
    assert_match "Name can&#39;t be blank", response.body
    assert_match "Name is too short (minimum is 3 characters)", response.body
    assert_select 'div.panel.panel-danger'
  end


  private
    def login
      post login_path, params: { session: { email: @user[:email],
                                            password: @user[:password] } }
    end


end