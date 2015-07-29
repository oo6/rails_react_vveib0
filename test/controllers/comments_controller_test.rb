require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @micropost = microposts(:most_recent)
    @comment = comments(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      xhr :post, :create, micropost_id: @micropost, comment: { content: 'body' }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      xhr :delete, :destroy, id: @comment
    end
    assert_redirected_to login_url
  end
end
