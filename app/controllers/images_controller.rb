class ImagesController < ApplicationController
  before_action :redirect_login_path_if_not_logged_in, only: [:new, :create]
  before_action :render_new_if_image_not_upload, only: [:create]

  def index
  end

  def show
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

  private

    def redirect_login_path_if_not_logged_in
      unless logged_in?
        flash[:danger] = 'Please Log in.'
        redirect_to login_path
      end
    end

    # 画像がアップロードされていなければnewテンプレートに返す
    def render_new_if_image_not_upload
      if params[:image].nil?
        flash.now[:danger] = "Input file."
        @image = Image.new
        render 'new'
      end
    end

    def image_params
      params.require(:image).permit(:image)
    end
end
