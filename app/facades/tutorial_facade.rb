class TutorialFacade < SimpleDelegator
  def initialize(tutorial, video_id = nil, current_user = nil)
    @tutorial = tutorial
    super(@tutorial)
    @video_id = video_id
    @current_user = current_user
  end

  def current_video
    if @video_id
      videos.find(@video_id)
    elsif videos.first
      videos.first
    else
      Video.new(description: '')
    end
  end

  def next_video
    if videos.first
      videos[current_video_index + 1] || current_video
    else
      Video.new
    end
  end

  def play_next_video?
    !(current_video.position >= maximum_video_position) if videos.first
  end

  private

  def current_video_index
    videos.index(current_video)
  end

  def maximum_video_position
    videos.max_by { |video| video.position }.position if videos.first
  end
end
