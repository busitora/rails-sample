class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_admin_user

  def index
    @q = User.page(params[:page]).ransack(params[:q])
    # TODO: N+1未対応
    @users = @q.result
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to admin_users_path, success: "ユーザー「#{@user.name}を作成しました」"
    else
      flash.now[:danger] = "ユーザーの登録に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def show
    @q = @user.tasks.page(params[:page]).per(10).ransack(params[:q])
    @tasks = @q.result
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: 'ユーザーを更新しました'
    else
      flash.now[:danger] = 'ユーザーを更新できませんでした'
      render :edit
      # TODO: 管理者のroleが0になった時の処理を考える
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: 'ユーザーを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
