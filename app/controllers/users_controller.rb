# hoge
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 保存の成功をここで扱う。
      flash[:success] = 'Success to register!'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  # strong parameter
  # postで送られた値をそのままオブジェクトに格納するのではなく、
  # 明示的に許可したカラムのパラメーターのみを通す仕組み
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
