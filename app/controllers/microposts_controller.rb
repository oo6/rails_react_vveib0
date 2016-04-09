class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :last]
  before_action :correct_user, only: [:destroy]

  def create
    if params[:id]
      new_micropost_params = micropost_params.merge(source_id: params[:id])
      @micropost = current_user.microposts.new(new_micropost_params)
    else
      @micropost = current_user.microposts.new(micropost_params)
    end

    if @micropost.save
      @micropost.create_mention_notification

      # 创建话题
      @micropost.content.scan(/#([\w]+|[\u4e00-\u9fa5]+)#/) do |match|
        topic = current_user.topics.find_or_create_by(content: $1)
        @micropost.topic_relationships.create(topic: topic)
      end

      # 关联图片
      if params[:pictures]
        params[:pictures].split(' ').each do |picture|
          @micropost.pictures.create(key: picture)
        end
      end

      respond_to do |format|
        format.html do
          flash[:success] = "微博发布成功！"
          redirect_to root_url
        end
        format.js
      end
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy

    respond_to do |format|
      format.html do
        flash[:success] = "微博已删除！"
        redirect_to request.referrer || root_url
      end
      format.js
    end
  end

  def last
    @microposts = Micropost.first(25)
  end

  def show
    @micropost = Micropost.find params[:id]
    @user = @micropost.user
    @comments = @micropost.comments.paginate(page: params[:page])
  end

  def expand
    @micropost = Micropost.find params[:id]
    @source_micropost_id = @micropost.source ? @micropost.source.id : 0
    @source_micropost_content = @micropost.source ? @micropost.source.content : ''
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
