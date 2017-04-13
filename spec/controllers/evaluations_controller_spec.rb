require 'rails_helper'
require 'helpers/helpers'

# Helpersクラスのメソッドの読み込み
RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe EvaluationsController, type: :controller do
  describe 'Post #create' do
    it 'not login' do
      @evaluation_good = FactoryGirl.attributes_for(:evaluation_good_param)
      expect{
          # パラメータと共にpostで投げる
          post :create, params: { evaluation: @evaluation_good }
        }.to change(Evaluation, :count).by(0)
      expect(response).to redirect_to login_path
      expect(flash[:danger]).not_to be_empty
    end

    context 'logged in' do
      before do
        @user = FactoryGirl.create(:user_2)
        @image = FactoryGirl.create(:image_already_created)
        @evaluation_good = FactoryGirl.attributes_for(:evaluation_good_param)
        @evaluation_good[:image_id] = @image.id
        login @user
      end

      it "success to create" do
        expect{
            # パラメータと共にpostで投げる
            post :create, params: { evaluation: @evaluation_good }
            # 成功するとレコードが新規に登録されるはず
          }.to change(Evaluation, :count).by(1)

        expect(response).to redirect_to root_path
      end

      it "failed to create due to duplication" do
        @evaluation_dup = FactoryGirl.create(:evaluation, user_id: @user.id, image_id: @image.id)
        expect{
            # パラメータと共にpostで投げる
            post :create, params: { evaluation: @evaluation_good }
          }.to change(Evaluation, :count).by(0)

        expect(response).to redirect_to root_path
        expect(flash[:danger]).not_to be_empty
      end
    end
  end

  # TODO:後以下のパターンのテストが必要
  ## ajaxパターン
  ## 評価したユーザ以外のユーザがevaluationを削除しに来たパターン
  describe 'Delete #destroy' do
    before do
      @user = FactoryGirl.create(:user_2)
      @image = FactoryGirl.create(:image_already_created)
      @evaluation = FactoryGirl.create(:evaluation, user_id: @user.id, image_id: @image.id)
    end
    it 'not login' do
      expect{
          # パラメータと共にpostで投げる
          delete :destroy, params: { id: @evaluation }
        }.to change(Evaluation, :count).by(0)
      expect(response).to redirect_to login_path
      expect(flash[:danger]).not_to be_empty
    end

    context 'logged in' do
      before do
        login @user
      end

      it "success to delete" do
        expect{
            # パラメータと共にpostで投げる
            delete :destroy, params: { id: @evaluation }
            # 成功するとレコードが新規に登録されるはず
          }.to change(Evaluation, :count).by(-1)

        expect(response).to redirect_to root_path
      end
    end
  end
end
