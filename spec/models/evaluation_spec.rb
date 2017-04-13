require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  # TODO: Destroyのテストも書きたい
  # TODO:複合ユニークのテストも書きたい

  describe 'model validation' do
    before do
      # imageオブジェクトを作成するときに、:userをaccosiationに指定しているため、あえて:user_2を指定している
      @user = FactoryGirl.create(:user_2)
      @image = FactoryGirl.create(:image_already_created)
      @evaluation = Evaluation.new(user_id: @user.id, image_id: @image.id, evaluation: true)
    end

    it 'should be valid' do
      expect(@evaluation).to be_valid
    end

    context 'should be not valid' do
      it 'user_id should be present' do
        @evaluation.user_id = ' '
        expect(@evaluation).not_to be_valid
      end

      it 'image_id should be present' do
        @evaluation.image_id = ' '
        expect(@evaluation).not_to be_valid
      end
    end
  end
end
