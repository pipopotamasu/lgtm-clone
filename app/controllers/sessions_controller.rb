class SessionsController < ApplicationController
  def new
  end

  def create
    # モデルから対象となるユーザを取得
    @user = User.find_by(email: params[:session][:email].downcase)
    # 取得したユーザが存在するかつ認証が通るのならばログイン成功
    if @user && @user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in @user
      redirect_to @user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
