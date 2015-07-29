require 'test_helper'

class CommentInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @micropost = microposts(:most_recent)
  end

  test "comment interface" do
    log_in_as(@user)
    get micropost_path(@micropost)
    assert_select 'div.pagination'
    # 有效提交
    content = "I love you!"
    assert_difference 'Comment.count', 1 do
      xhr :post, micropost_comments_path(@micropost), comment: { content: content }
    end

    assert_difference 'Comment.count', 1 do
      post micropost_comments_path(@micropost), comment: { content: content }
    end
    assert_redirected_to micropost_path(@micropost)
    follow_redirect!
    assert_match content, response.body

    # 删除一条评论
    assert_select 'a>i.fa.fa-trash-o'
    first_comment = @user.comments.paginate(page: 1).first
    assert_difference 'Comment.count', -1 do
      delete comment_path(first_comment)
    end

    last_comment = @user.comments.paginate(page: 1).last
    assert_difference 'Comment.count', -1 do
      xhr :delete, comment_path(last_comment)
    end
  end
end
