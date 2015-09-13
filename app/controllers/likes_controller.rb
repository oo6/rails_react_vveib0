class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :find_subject, only: [:create, :destroy]

  def create
    @like = @subject.likes.find_or_create_by user: current_user
    @like.notifications.create(user: @subject.user, name: 'like') if current_user != @subject.user

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @subject.likes.where(user: current_user).delete_all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def inbox
    @notifications = current_user.notifications.named('like').includes(:subject).paginate(page: params[:page])
  end

  def outbox
    @likes = current_user.likes.paginate(page: params[:page])
  end

  private
    def find_subject
      resource, id = request.path.split('/')[1, 2]
      @subject = resource.singularize.classify.constantize.find(id)
    end
end
