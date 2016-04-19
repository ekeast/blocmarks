class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find(email: params[:sender])
    @topic = @user.topics.find_or_create_by(title: params[:subject])
    @bookmark = @topic.bookmarks.new(url: params[:body])
  end
end
