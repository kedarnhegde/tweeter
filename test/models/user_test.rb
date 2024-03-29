require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@gmail.com", 
                     password: "password123", password_confirmation: "password123")
  end

  test "should be valid" do
    assert @user.valid?
  end
  test "Name cannot be blank" do 
    @user.name = "   "
    assert_not @user.valid?
  end
  test "email cannot be blank" do
    @user.email = "  "
    assert_not @user.valid?
  end
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  test "email validation of format - valid ids" do
    valid_ids = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_ids.each do |valid_id|
      @user.email = valid_id
      assert @user.valid?, "#{valid_id.inspect} should be valid"
    end
  end
  test "email validation of format - invalid ids" do
    invalid_ids =  %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_ids.each do |invalid_id|
      @user.email = invalid_id
      assert_not @user.valid?, "#{invalid_id.inspect} should be invalid"
    end
  end
  test "uniquie email ids" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "MixCase@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  test "password cannot be blank" do
    @user.password = @user.password_confirmation = "  " * 8
    assert_not @user.valid?
  end
  test "minimum length for password" do
    @user.password = @user.password_confirmation = "aaaa"
    assert_not @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  test "should follow and unfollow a user" do
    kedar = users(:kedar)
    lando  = users(:lando)
    assert_not kedar.following?(lando)
    kedar.follow(lando)
    assert kedar.following?(lando)
    assert lando.followers.include?(kedar)
    kedar.unfollow(lando)
    assert_not kedar.following?(lando)
  end

  test "fedd should have the right posts" do
    kedar = users(:kedar)
    user1 = users(:user_1)
    user2 = users(:user_2)
    kedar.microposts.each do |post_following|
      assert kedar.feed.include?(post_following)
    end
    user1.microposts.each do |post_following|
      assert kedar.feed.include?(post_following)
    end
    user2.microposts.each do |post_following|
      assert kedar.feed.include?(post_following)
    end
  end
end
