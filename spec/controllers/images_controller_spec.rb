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
      get :show
      expect(response).to have_http_status(:success)
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

end
