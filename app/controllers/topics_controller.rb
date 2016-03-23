class TopicsController < ApplicationController
  def index
    @topics = Topic.all.paginate(page: params[:page])
  end

  def show
    @topic = Topic.find_by(content: params[:content])
  end
end
