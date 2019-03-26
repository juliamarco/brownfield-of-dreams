class ActivationController < ApplicationController
  before_action :require_user

  def show
    if current_user.status == 'Inactive' && current_user.temporary_token == params[:token]
      user = User.find(current_user.id)
      user.update(status: 'Active', temporary_token: '')
    else
      render file: 'errors/not_found', status: 404
    end
  end
end
