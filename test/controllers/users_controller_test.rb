require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = User.first
    session[:current_user_id] = @user.id
  end

  test "verify after email update" do
    put :update, id: @user.id, user: { email: "new@example.com" }
    u = @user.reload
    assert u.phone_verified, "Phone should be verified"
    refute u.email_verified, "Email should not be verified"
  end

  test "verify after phone update" do
    put :update, id: @user.id, user: { cellphone: "1231231234" }
    u = @user.reload
    refute u.phone_verified, "Phone should not be verified"
    assert_equal "+11231231234", u.cellphone
    assert u.email_verified, "Email should not be verified"
  end

  test "correct behavior durring username change" do
    put :update, id: @user.id, user: { name: "jane" }
    assert_equal "User jane updated", flash[:success]
    assert_redirected_to user_path(@user)
    u = @user.reload
    assert u.phone_verified, "Phone should be verified"
    assert u.email_verified, "Email should not be verified"
    assert_equal "jane", u.name
  end
end
