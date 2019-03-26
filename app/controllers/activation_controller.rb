class ActivationController < ApplicationController
  before_action :require_user

  def show
    if current_user.status == 'Inactive'
      current_user.update(status: 'Active')
    else
      render file: 'errors/not_found', status: 404
    end
  end
end
