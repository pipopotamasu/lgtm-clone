require "rails_helper"

RSpec.describe TopPagesController, type: :controller do
  describe 'GET #index' do
    it 'should get index' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end
end
