class LikesController < ApplicationController
  before_action :logged_in_user, :find_subject

  def create
    @subject.likes.find_or_create_by user: current_user
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

  private
    def find_subject
      resource, id = request.path.split('/')[1, 2]
      @subject = resource.singularize.classify.constantize.find(id)
    end
end
