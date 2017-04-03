require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'should get new' do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end

  describe 'Post #create' do
    before do
      # FactoryGirl
      ## attributes_for・・・オブジェクト生成に使われる属性集合を返す
      @params = FactoryGirl.attributes_for(:user)
    end
    it 'valid signup information' do
      expect{
          # パラメータと共にpostで投げる
            post :create, params: { user: @params }
          # 成功するとレコードが新規に登録されるはず
        }.to change(User, :count).by(1)
      # 成功時はshowにリダイレクトするはず
      # assignsで新規登録したidをパラメータに付随させている
      # 以下でも大丈夫
      #expect(response).to(redirect_to(user_path(assigns[:user])))
      expect(response).to redirect_to user_path assigns[:user]
      expect(flash[:success]).not_to be_empty
    end

    it 'invalid signup information' do
      # invalidにするためnameを空にする
      @params[:name] = ''
      expect{
          # パラメータと共にpostで投げる
            post :create, params: { user: @params }
          # 失敗するとレコードが新規にできないはず
          }.to change(User, :count).by(0)
      # 失敗時はnewテンプレートがレンダリングされるはず
      expect(response).to render_template('new')
    end
  end
end
