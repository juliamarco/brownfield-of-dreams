class TutorialsFacade

  def initialize(current_user)
    @current_user = current_user
  end

  def tutorials
    if @current_user
      Tutorial.all
    else
      Tutorial.where(classroom: false)
    end
  end
  
end
