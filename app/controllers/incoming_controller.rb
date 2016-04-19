class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.where(email: "#{params[:sender]}")
    @topic = Topic.find_or_create_by(title: params[:subject])
    @bookmark = @topic.bookmarks.new(url: params[:body])
  end
end
