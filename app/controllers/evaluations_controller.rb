class EvaluationsController < ApplicationController
  before_action :redirect_login_path_if_not_logged_in, only: [:create, :destroy]

  def create
    @evaluation = current_user.evaluations.build(evaluation_params)
    if @evaluation.save
      @image = Image.find(@evaluation.image_id)
    else
      flash[:danger] = "Failed to evaluate."
    end

    # 通常の同期的リクエストならformat.htmlの処理
    # 非同期リクエストならformat.jsの処理が実行される
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    evaluation = Evaluation.find(params[:id])
    @image = Image.find(evaluation.image_id)
    evaluation.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end


  private
    # TODO:images_contorllerと処理を統一する
    def redirect_login_path_if_not_logged_in
      unless logged_in?
        flash[:danger] = 'Please Log in.'
        redirect_to login_path
      end
    end

    def evaluation_params
      params.require(:evaluation).permit(:image_id, :evaluation)
    end
end
