# hoge
class UsersController < ApplicationController
  before_action :redirect_login_path_if_not_logged_in, only: %i[index show destroy]
  before_action :redirect_to_root_if_not_right_user, only: %i[index show destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if current_user && current_user.admin?
      create_user_by_admin
    elsif logged_in?
      flash[:danger] = 'Invalid access occuered.'
      redirect_to root_url
    else
      create_user
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  private

  # strong parameter
  # postで送られた値をそのままオブジェクトに格納するのではなく、
  # 明示的に許可したカラムのパラメーターのみを通す仕組み
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def user_params_for_admin
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      # 保存の成功をここで扱う。
      log_in @user
      # セッションの永続化
      remember @user
      flash[:success] = 'Success to register!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def create_user_by_admin
    @user = User.new(user_params_for_admin)
    if @user.save
      flash[:success] = 'Success to register!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def redirect_to_root_if_not_right_user
    # admin権限を持っていれば処理しない
    return if current_user.admin?
    # 自身のshowページにアクセスしようとしているなら処理しない
    return if params[:id].to_i == current_user.id
    # 上記以外の場合、つまりadmin権限がないにも関わらず他人にアクセスしようとしている時はrootに返す
    flash[:danger] = 'Access denied.'
    redirect_to root_url
  end
end
