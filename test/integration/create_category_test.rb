require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "johndoe", email:"jo@live.com",
      password:"interi123", admin:true)
  end

  test "getting new category form and creating it" do
    login_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "Sports"} }
      assert_response  :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "getting new category form and reject invalid submission" do
    login_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: ""} }
    end
    assert_select 'h3'
  end
end
