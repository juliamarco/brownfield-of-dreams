class WelcomeController < ApplicationController
  def index # rubocop:disable Metrics/AbcSize
    render locals: {
      facade: TutorialsFacade.new(current_user)
    }
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5) # rubocop:disable Metrics/LineLength
    else
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end
end
