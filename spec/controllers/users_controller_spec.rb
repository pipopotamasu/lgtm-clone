require 'rails_helper'
require 'helpers/helpers'

# Helpersクラスのメソッドの読み込み
RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    before do
      @user_not_admin = FactoryGirl.create(:user)
      @user_admin = FactoryGirl.create(:user_admin)
    end
    it 'should get index without login' do
      get :index
      expect(flash[:danger]).not_to be_empty
      expect(response).to redirect_to login_path
    end

    context 'should get index with login' do
      it 'is admin user' do
        login @user_admin
        get :index
        expect(response).to render_template :index
      end

      it 'is not admin user' do
        login @user_not_admin
        get :index
        expect(flash[:danger]).not_to be_empty
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET #new' do
    it 'should get new' do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end

  describe 'GET #show' do
    before do
      @user_not_admin = FactoryGirl.create(:user)
      @user_admin = FactoryGirl.create(:user_admin)
    end
    it 'should get show without login' do
      get :show, params: { id: @user_not_admin }
      expect(flash[:danger]).not_to be_empty
      expect(response).to redirect_to login_path
    end

    context 'should get show with login' do
      it 'is admin user' do
        login @user_admin
        get :show, params: { id: @user_admin }
        expect(response).to render_template :show
      end

      context 'is not admin user' do
        before do
          login @user_not_admin
        end
        # 自身のshowページにアクセスする場合
        it 'is access to yourself' do
          get :show, params: { id: @user_not_admin }
          expect(response).to render_template :show
        end

        # 他人のshowページにアクセスする場合
        it 'is not access to yourself' do
          get :show, params: { id: @user_admin }
          expect(flash[:danger]).not_to be_empty
          expect(response).to redirect_to root_url
        end
      end
    end
  end

  describe 'Post #create' do
    # admin権限を持たないユーザーの作成
    context 'create no admin user' do
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
        # expect(response).to(redirect_to(user_path(assigns[:user])))
        # assigns・・・controllerのインスタンス変数にアクセス
        expect(response).to redirect_to user_path assigns[:user]
        expect(flash[:success]).not_to be_empty
        # loginしているかを確認
        # controllerのインスタンス変数を取得
        user = assigns[:user]
        expect(session[:user_id]).to eq user.id
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

    # admin権限を持つユーザーの作成
    context 'create admin user' do
      before do
        # FactoryGirl
        ## attributes_for・・・オブジェクト生成に使われる属性集合を返す
        @user_admin = FactoryGirl.create(:user_admin)
        @user_not_admin = FactoryGirl.create(:user)
        @params_not_admin = FactoryGirl.attributes_for(:user_2)
        @params_admin = FactoryGirl.attributes_for(:user_admin_2)
      end

      context 'by admin user' do
        before do
          login @user_admin
        end
        it 'valid signup information' do
          expect{
              # パラメータと共にpostで投げる
                post :create, params: { user: @params_admin }
              # 成功するとレコードが新規に登録されるはず
            }.to change(User, :count).by(1)
          # 成功時はshowにリダイレクトするはず
          # assignsで新規登録したidをパラメータに付随させている
          # 以下でも大丈夫
          # expect(response).to(redirect_to(user_path(assigns[:user])))
          # assigns・・・controllerのインスタンス変数にアクセス
          expect(response).to redirect_to user_path assigns[:user]
          expect(flash[:success]).not_to be_empty
        end

        it 'invalid signup information' do
          # invalidにするためnameを空にする
          @params_admin[:name] = ''
          expect{
              # パラメータと共にpostで投げる
                post :create, params: { user: @params_admin }
              # 失敗するとレコードが新規にできないはず
              }.to change(User, :count).by(0)
          # 失敗時はnewテンプレートがレンダリングされるはず
          expect(response).to render_template('new')
        end
      end

      context 'by not admin user' do
        before do
          login @user_not_admin
        end

        it 'failed to create admin user' do
          expect{
              # パラメータと共にpostで投げる
                post :create, params: { user: @params_admin }
              # 成功するとレコードが新規に登録されるはず
            }.to change(User, :count).by(0)
          # 成功時はshowにリダイレクトするはず
          # assignsで新規登録したidをパラメータに付随させている
          # 以下でも大丈夫
          # expect(response).to(redirect_to(user_path(assigns[:user])))
          # assigns・・・controllerのインスタンス変数にアクセス
          expect(response).to redirect_to root_url
          expect(flash[:danger]).not_to be_empty
        end
      end
    end
  end

  describe 'DELETE #delete' do
    before do
      @user_not_admin = FactoryGirl.create(:user)
      @user_admin = FactoryGirl.create(:user_admin)
    end

    it 'delete by admin user(success to delete)' do
      login @user_admin
      expect{
            delete :destroy, params: { id: @user_not_admin }
          }.to change(User,:count).by(-1)
      expect(response).to redirect_to users_path
    end

    it 'delete by not admin user(failed to delete)' do
      login @user_not_admin
      expect{
            delete :destroy, params: { id: @user_admin }
          }.to change(User,:count).by(0)
      expect(response).to redirect_to root_url
    end
  end
end
