require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get home_Index_url
    assert_response :success
  end

end
