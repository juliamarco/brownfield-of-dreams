class FriendshipsController < ApplicationController
  before_action :require_user

  def create
    friend = User.find_by(uid: friendship_params[:format])
    friendship = Friendship.new(user: current_user, friend: friend)
    if friendship.save
      redirect_to dashboard_path
    else
      flash[:error] = "This friendship could not be created"
    end
  end

  private

  def friendship_params
    params.permit(:format)
  end


end
