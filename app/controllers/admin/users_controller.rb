class Admin::UsersController < ApplicationController
    before_action :admin_user

    def index
        @users = User.all.includes(:tasks)
    end

    def new
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

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "ユーザーを削除しました"
        redirect_to admin_users_path
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def admin_user
      unless current_user.admin?
          flash[:notice] = "管理者以外はアクセス不可"
          redirect_to tasks_path
      end
    end
    
end
