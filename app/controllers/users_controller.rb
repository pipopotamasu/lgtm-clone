# hoge
class UsersController < ApplicationController
  before_action :is_right_user, only: [:index, :show, :destroy]

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

  def is_right_user
    # ログインしているかどうか
    if logged_in?
      # admin権限を持っているかどうか
      unless current_user.admin?
        # 自身以外のshowページにアクセスしようとしているなら、rootページに遷移させる
        if params[:id].to_i != current_user.id
          flash[:danger] = 'Access denied.'
          redirect_to root_url
        end
      end
    else
      # ログインしていなければログインページに遷移させる
      flash[:danger] = 'Please log in.'
      redirect_to login_path
    end
  end
end
