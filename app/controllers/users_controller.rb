class UsersController < ApplicationController
  def show
    render locals: {
      facade: DashboardFacade.new({ quantity: 5 }, current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      full_name = user.first_name + ' ' + user.last_name
      flash[:success] = "Logged in as #{full_name}"
      flash[:info] = 'This account has not yet been activated. Please check your email.'
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      @user = User.new
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
