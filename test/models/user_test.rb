require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.find(1)
    @u2 = User.find(2)
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

  test "user password length min is 6 chars" do
    @user.password = @user.password_confirmation = "j" * 5
    assert_not @user.valid?
  end

  test "user needs valid email" do
    @user.email = "hello@world"
    assert_not @user.valid?
    @user.email = ""
    assert_not @user.valid?
  end

  test "user needs unique email" do
    @user.email = @u2.email
    assert_not @user.valid?
  end

  test "user email addresses gets downcased" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "user cellphone gets formatted" do
    humanized_cellphone = "(555)555-5555"
    @user.cellphone = humanized_cellphone
    @user.save
    assert_equal "+15555555555", @user.reload.cellphone
  end
end
