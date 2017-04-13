require 'rails_helper'
require 'helpers/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe ImagesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      @image = FactoryGirl.create(:image_already_created)
      get :show, params: { id: @image }
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('show')
    end
  end

  describe "GET #new" do
    context 'not login' do
      it "should redirect to login path" do
        get :new
        expect(response).to redirect_to login_path
        expect(flash[:danger]).not_to be_empty
      end
    end

    context 'logged in' do
      it "returns http success" do
        user = FactoryGirl.create(:user)
        login user
        get :new
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template('new')
      end
    end
  end

  describe 'Post #create' do
    it 'not login' do
      @image = FactoryGirl.attributes_for(:image)
      expect {
        # パラメータと共にpostで投げる
        post :create, params: { image: @image }
      }.to change(Image, :count).by(0)
      expect(response).to redirect_to login_path
      expect(flash[:danger]).not_to be_empty
    end

    context 'logged in' do
      before do
        @user = FactoryGirl.create(:user)
        @image = FactoryGirl.attributes_for(:image)
        login @user
      end

      it "success to create" do
        expect {
          # パラメータと共にpostで投げる
          post :create, params: { image: @image }
          # 成功するとレコードが新規に登録されるはず
        }.to change(Image, :count).by(1)

        expect(response).to redirect_to root_path
        expect(flash[:success]).not_to be_empty
      end

      it "failed to create " do
        @image.clear
        expect {
          # パラメータと共にpostで投げる
          post :create, params: { image: @image }
        }.to change(Image, :count).by(0)

        expect(response).to render_template('new')
        expect(flash[:danger]).not_to be_empty
      end
    end
  end

  describe "DELETE #destroy" do
    it 'not login' do
      @image = FactoryGirl.create(:image_already_created)
      expect {
        delete :destroy, params: { id: @image }
      }.to change(User, :count).by(0)
      expect(response).to redirect_to login_path
    end
  end

  context 'logged in' do
    before do
      @image = FactoryGirl.create(:image_already_created)
    end
    it 'is not admine' do
      @user = FactoryGirl.create(:user_2)
      login @user
      expect {
        delete :destroy, params: { id: @image }
      }.to change(User, :count).by(0)
      expect(response).to redirect_to root_url
      expect(flash[:danger]).not_to be_empty
    end

    it 'admin user' do
      @user = FactoryGirl.create(:user_admin_2)
      login @user
      expect {
        delete :destroy, params: { id: @image }
      }.to change(Image, :count).by(-1)
      expect(response).to redirect_to root_url
      expect(flash[:success]).not_to be_empty
    end
  end
end
