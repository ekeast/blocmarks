class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.where(email: params[:sender]).first
    @topic = @user.topics.find_or_create_by(title: params[:subject])
    @bookmark = @topic.bookmarks.create(url: params["body-plain"])

    head 200
  end
end
