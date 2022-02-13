require "test_helper"

class InstructorsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get instructors_home_url
    assert_response :success
  end
end
