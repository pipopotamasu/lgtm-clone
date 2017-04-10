require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'model validation' do
    before do
      # FactoryGirl
      ## build・・・modleオブジェクトの作成(dbに反映されない)
      ## create・・・modleオブジェクトの作成(dbに反映される)
      @user = FactoryGirl.create(:user)
      @image = Image.new(image: fixture_file_upload('spec/factories/images/test.png', 'image/png'), user_id: @user.id)
    end

    it 'should be valid' do
      expect(@image).to be_valid
    end

    context 'user_id' do
      it 'user_id should be present' do
        @image.user_id = ' '
        expect(@image).not_to be_valid
      end
    end

    context 'image' do
      it 'user_id should be present' do
        @image.image = ' '
        expect(@image).not_to be_valid
      end
    end
  end
end
