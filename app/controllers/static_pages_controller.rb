class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.new
      @qiniu_upload_token = generate_qiniu_upload_token
      @feed_items = current_user.feed.paginate(page: params[:page])
      @topics = Topic.last 5
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
