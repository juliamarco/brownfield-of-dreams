class ActivationController < ApplicationController
  before_action :require_user

  def show
    if current_user.status == 'Inactive' && current_user.temporary_token == params[:token]
      user = User.find(current_user.id)
      user.update(status: 'Active', temporary_token: '')
    else
      four_oh_four
    end
  end
end
