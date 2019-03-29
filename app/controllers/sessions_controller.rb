class SessionsController < ApplicationController
  def new
    @user ||= User.new # rubocop:disable Naming/MemoizedInstanceVariableName
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password]) # rubocop:disable Style/SafeNavigation, Metrics/LineLength
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
