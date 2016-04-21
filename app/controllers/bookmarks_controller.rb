class BookmarksController < ApplicationController
  before_action :set_topic
  before_action :set_bookmark, only: [:show, :edit, :destroy]
  include Pundit

  def show
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
  end

  def create
    @bookmark = @topic.bookmarks.new(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark has been created!"
      redirect_to @topic
    else
      flash[:alert] = "Failed to create bookmark."
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "Bookmark has been successfully destroyed."
      redirect_to @topic
    else
      flash.now[:alert] = "Bookmark was not deleted."
      redirect_to @topic
    end
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :topic_id)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

end
