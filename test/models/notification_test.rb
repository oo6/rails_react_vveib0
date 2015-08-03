require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    user = users(:michael)
    comment = comments(:three)
    @notification = Notification.create(user: user, subject: comment, name: 'comment')
  end

  test "should be valid" do
    assert @notification.valid?
  end
  
  test "user id should be present" do
    @notification.user_id = nil
    assert_not @notification.valid?
  end

  test "subject should be present" do
    @notification.subject = nil
    assert_not @notification.valid?
  end

  test "name should be present" do
    @notification.name = ""
    assert_not @notification.valid?
  end

  test "order should be two last" do
    assert_equal Notification.last, notifications(:two)
  end

  test "unread order should be two last" do
    assert_equal Notification.unread.last, notifications(:two)
  end

  test "named like order should be three first" do
    assert_equal Notification.named('like').first, notifications(:three)
  end
end
