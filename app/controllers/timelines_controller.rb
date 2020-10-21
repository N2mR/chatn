class TimelinesController < ApplicationController
  def index
    @timelines = Timeline.where("user_id IN (:following_ids) OR user_id = :user_id", 
                                following_ids: following_user, user_id: current_user.id).order(created_at: "DESC")
  end

  def create
    @timeline = Timeline.new(timeline_params)
    @content = params[:content]
    @timeline.content = @content
    @timeline.user_id = current_user.id
    if @timeline.valid?
      @timeline.save
      redirect_to timelines_url
    else
      flash[:danger] = 'タイムラインの投稿に失敗しました'
      redirect_to timelines_url
    end
  end

  def destroy
    @timeline = Timeline.find(params[:id])
    if @timeline.destroy
      flash.now[:success] = 'タイムラインを削除しました'
    else
      flash.now[:danger] = '削除に失敗しました'
    end
  end

  private
    def timeline_params
      params.permit(:content,:user_id)
    end

    def following_user
      @following_user = []
      @allusers = current_user.active_relationships.each do |user|
        @following_user << user.followed_id
      end
      @following_user
    end
end
