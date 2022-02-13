require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get students_home_url
    assert_response :success
  end
end
