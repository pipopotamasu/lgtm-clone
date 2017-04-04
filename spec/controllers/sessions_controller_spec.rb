require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(:success)
      expect(response).to render_template('new')
    end
  end

  describe 'Post #create' do
    it 'invalid login information' do
      expect(session[:user_id]).to be_nil
      post :create, params: { session: { email: "", password: "" } }
      # 失敗時はsessionに何も格納されずにnewテンプレートがレンダリングされるはず
      expect(session[:user_id]).to be_nil
      expect(response).to render_template('new')
      # flashにエラーメッセージが格納されているはず
      expect(flash[:danger]).not_to be_empty

      # newテンプレートに再移動
      get :new
      # その際はflashが空になっているはず
      expect(flash[:danger]).to be_nil
    end

    it 'valid login information' do
      expect(session[:user_id]).to be_nil
      # test用DBにFactoryGirlのuserを登録する
      user = FactoryGirl.create(:user)
      post :create, params: { session: { email: user.email, password: user.password } }
      # 成功時はsessionにidが格納され、showテンプレートがレンダリングされるはず
      expect(session[:user_id]).to eq user.id
      # assigns・・・controllerのインスタンス変数にアクセス
      expect(response).to redirect_to user_path assigns[:user]
    end
  end

  describe 'DELETE #logout' do
    it 'success to logout' do
      expect(session[:user_id]).to be_nil

      # 一旦loginする
      user = FactoryGirl.create(:user)
      post :create, params: { session: { email: user.email, password: user.password } }
      expect(session[:user_id]).to eq user.id

      # deleteを実行
      delete :destroy
      # sessionが空になっていること
      expect(session[:user_id]).to be_nil

      # rootにリダイレクトしていること
      expect(response).to redirect_to root_url

    end
  end
end
