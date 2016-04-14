class TopicsController < ApplicationController
  def index
    @topics = current_user.topics
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic has been created!"
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error in creating the topic."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "Topic was deleted successfully."
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :index
    end
  end

  private

  def topic_params
    params.require(:topic).permit([:title])
  end
end
