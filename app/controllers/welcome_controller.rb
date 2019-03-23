class WelcomeController < ApplicationController
  def index
    render locals: {
      facade: TutorialsFacade.new(current_user)
    }
    # if params[:tag]
    #   @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    # else
    #   @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
    # end
  end
end
