class UsersController < ApplicationController
  def show
    render locals: {
      facade: DashboardFacade.new({ quantity: 5 }, current_user)
    }
  end

  def new
    @user = User.new
  end

  def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      full_name = user.first_name + ' ' + user.last_name
      user.update(temporary_token: SecureRandom.urlsafe_base64.to_s)
      flash[:success] = "Logged in as #{full_name}"
      flash[:info] = 'This account has not yet been activated. Please check your email.' # rubocop:disable Metrics/LineLength
      email = current_user.email
      token = current_user.temporary_token
      UserNotifierMailer.inform(email, token).deliver_now
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
