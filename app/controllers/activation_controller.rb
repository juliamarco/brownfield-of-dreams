class ActivationController < ApplicationController
  before_action :require_user

  def show
    token = current_user.temporary_token
    if current_user.status == 'Inactive' && token == params[:token]
      user = User.find(current_user.id)
      user.update(status: 'Active', temporary_token: '')
    else
      four_oh_four
    end
  end
end
