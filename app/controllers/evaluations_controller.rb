class EvaluationsController < ApplicationController
  before_action :redirect_login_path_if_not_logged_in, only: [:create, :destroy]

  def create
    @evaluation = current_user.evaluations.build(evaluation_params)
    if @evaluation.save
      flash[:success] = "Success to evaluate!"
      redirect_to root_url
    else
      p @evaluation
      flash[:danger] = "Failed to evaluate."
      redirect_to root_url
    end
  end

  def destroy
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
