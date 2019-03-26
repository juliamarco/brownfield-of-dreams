class ActivationController < ApplicationController
  def show
    current_user.update(status: "Active")
  end
end
