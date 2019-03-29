class FriendshipsController < ApplicationController
  before_action :require_user

  def create
    friend = User.find_by(uid: friendship_params[:uid])
    user = User.find(current_user.id)
    friendship = Friendship.new(user: user, friend: friend)
    if friendship.save
    else
      flash[:error] = 'This friendship could not be created'
    end
    redirect_to dashboard_path
  end

  private

  def friendship_params
    params.permit(:uid)
  end
end
