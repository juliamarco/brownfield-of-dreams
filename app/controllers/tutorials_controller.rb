class TutorialsController < ApplicationController
  def index
    render locals: {
      facade: TutorialsFacade.new(current_user)
    }
  end

  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom == true
      if current_user
        render locals: {
          facade: TutorialFacade.new(tutorial, params[:video_id], current_user)
        }
      else
        flash[:error] = 'You have to register to access this tutorial'
        redirect_to tutorials_path
      end
    else
      render locals: {
        facade: TutorialFacade.new(tutorial, params[:video_id])
      }
    end
  end
end
