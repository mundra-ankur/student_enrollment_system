require "../test_helper"

class AdminTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should not save new admin without any information" do
    admin = Admin.new
    assert_not admin.save
  end

  test "should not save admin without email" do
    admin1 = admins(:one)
    admin1.name = "ada"
    admin1.email = nil
    admin1.phone = "12345"
    admin1[:encrypted_password] = "123121"
    admin1.password = 123123
    assert_not admin1.save
  end

  test "should not save admin without phone" do
    admin1 = admins(:one)
    admin1.name = "admin1@ncsu.edu"
    admin1.email = nil
    admin1[:encrypted_password] = "123121"
    admin1.password = 123123
    assert_not admin1.save
  end

  test "should admins with same phone numbers" do
    admin1 = Admin.new
    admin1.name = "ada"
    admin1.email = "admin1@ncsu.edu"
    admin1.phone = "12345"
    admin1[:encrypted_password] = "123121"
    admin1.password = 123123
    assert admin1.save

    admin2 = Admin.new
    admin2.email = "admin2@ncsu.edu"
    admin2.phone = "12345"
    admin2[:encrypted_password] = "123121"
    admin2.password = 123121
    # debugger
    assert_not admin2.save
  end

  test "unable to give bad format for email " do
    admin1 = Admin.new
    admin1.name = "ada"
    admin1.email = "admin1"
    admin1.phone = "12345"
    admin1[:encrypted_password] = "123121"
    admin1.password = 123123
    assert_not admin1.save
  end


end
