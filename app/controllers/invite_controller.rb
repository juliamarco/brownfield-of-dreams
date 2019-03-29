class InviteController < ApplicationController
  def new # rubocop:disable Style/EmptyMethod
  end

  def create # rubocop:disable Metrics/AbcSize
    user_hash = GithubService.new.get_user(params[:github_handle], current_user)
    if user_hash[:login]
      email = "#{user_hash[:id]}+#{user_hash[:login]}@users.noreply.github.com"
      InviteMailer.invite(email, current_user.handle, user_hash[:login]).deliver_now # rubocop:disable Metrics/LineLength
      flash[:success] = 'Successfully sent invite!'
      redirect_to dashboard_path
    else
      flash[:danger] = "The Github user you selected doesn't have an email address associated with their account." # rubocop:disable Metrics/LineLength
      render :'invite/new'
    end
  end
end
