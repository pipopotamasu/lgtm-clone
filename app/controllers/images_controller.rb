class ImagesController < ApplicationController
  before_action :redirect_login_path_if_not_logged_in, only: [:new, :create]
  def index
  end

  def show
  end

  def new
    @image = Image.new
  end

  def create
  end

  private
  
    def redirect_login_path_if_not_logged_in
      unless logged_in?
        flash[:danger] = 'Please Log in.'
        redirect_to login_path
      end
    end
end
