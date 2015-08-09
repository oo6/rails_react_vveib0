class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :last]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.new(micropost_params)
    if @micropost.save
      @micropost.create_mention_notification
      
      flash[:success] = "微博发布成功！"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "微博已删除！"
    redirect_to request.referrer || root_url
  end

  def last
    @microposts = Micropost.first(25)
  end

  def show
    @micropost = Micropost.find params[:id]
    @user = @micropost.user
    @comments = @micropost.comments.paginate(page: params[:page])
  end

  def get_last_five_comments
    comments = Micropost.find(params[:id]).comments.first(5)
    data = {}
    comments.each do |comment|
      user = comment.user
      data[comment.id] = {
        content: comment.content,
        created_at: comment.created_at,
        user: {
          id: user.id,
          name: user.name,
          portrait_url: portrait_url(user)
        }
      }
    end
    respond_to do |format|
      format.json { render json: data }
    end
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
