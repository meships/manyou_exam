class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
    
  def new
    redirect_to user_path(current_user.id) if logged_in?
    @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        redirect_to user_path(@user.id)
      else
        render :new
      end
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:notice] = "権限がありません"
      redirect_to  tasks_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "情報を編集しました！"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def show
      @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
