require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  describe 'model validation' do
    before do
      # FactoryGirl
      ## build・・・modleオブジェクトの作成(dbに反映されない)
      ## create・・・modleオブジェクトの作成(dbに反映される)
      @user = FactoryGirl.create(:user)
      @image = FactoryGirl.create(:image)
      @evaluation = Evaluation.new(user_id: @user.id, image_id: @image, evaluation: true)
    end

    it 'should be valid' do
      expect(@evaluation).to be_valid
    end

    context 'should be not valid' do
    
    end
  end
end
