require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = microposts(:orange).likes.new(user: users(:michael))
  end

  test "should be valid" do
    assert @like.valid?
  end
  
  test "user id should be present" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "subject should be present" do
    @like.subject = nil
    assert_not @like.valid?
  end
end
