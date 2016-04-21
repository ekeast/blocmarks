class LikesController < ApplicationController

  include Pundit
  def index
    @likes = Like.bookmarks.all
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    authorize like
    if like.save
      flash[:notice] = "You liked the bookmark!"
      redirect_to @bookmark.topic
    else
      flash[:alert] = "Bookmark was not liked."
      redirect_to @bookmark.topic
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

    authorize like
    if like.destroy
      flash[:notice] = "You unliked the bookmark."
      redirect_to @bookmark.topic
    else
      flash[:alert] = "Bookmark was not unliked."
      redirect_to @bookmark.topic
    end
  end
end
