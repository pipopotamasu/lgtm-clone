class ImagesController < ApplicationController
  before_action :redirect_login_path_if_not_logged_in, only: %i[new create destroy]
  before_action :render_new_if_image_not_upload, only: [:create]

  def index; end

  def show
    @image = Image.find(params[:id])
    @user = User.find(@image.user_id)
  end

  def new
    @image = Image.new
  end

  def create
    # build・・・newのalias
    @image = current_user.images.build(image_params)
    if @image.save
      flash[:success] = "Image uploaded!"
      redirect_to root_url
    else
      flash.now[:danger] = "Failed to upload."
      render 'new'
    end
  end

  def destroy
    if current_user.admin?
      Image.find(params[:id]).destroy
      flash[:success] = 'Image deleted'
    else
      flash.now[:danger] = 'Illegal operation and User.'
    end
    redirect_to root_url
  end

  private

  # 画像がアップロードされていなければnewテンプレートに返す
  def render_new_if_image_not_upload
    # 画像がアップロードされていれば処理しない
    return unless params[:image].nil?
    flash.now[:danger] = "Input file."
    @image = Image.new
    render 'new'
  end

  def image_params
    params.require(:image).permit(:image)
  end
end
