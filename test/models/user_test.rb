require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.find(1)
  end

  test "user has name" do
    assert @user.name == "jamie", "Username incorrect"
  end

  test "user has email" do
    assert @user.email == "jamie@acme.org", "User email incorrect"
  end

  test "user has cellphone" do
    assert @user.cellphone == "+15555555555", "User cellphone incorrect"
  end

  test "user has contact_pref" do
    assert @user.contact_pref == "phone", "User contact_pref incorrect"
  end

  test "user has phone_verified" do
    assert @user.phone_verified == true, "User phone_verified not working"
  end

  test "user has email_verified" do
    assert @user.email_verified == true, "User email_verified not working"
  end

  test "user has password_digest" do
    refute @user.password_digest.blank?, "User password_digest not working"
  end
end
