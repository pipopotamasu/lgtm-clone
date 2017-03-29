require 'rails_helper'

RSpec.describe User, type: :model do
  describe "model validation" do
    # 各テストスイート実行前の共通処理
    before do
      # FactoryGirl
      ## build・・・modleオブジェクトの作成(dbに反映されない)
      ## create・・・modleオブジェクトの作成(dbに反映される)
      @user = FactoryGirl.build(:user)
    end

    it "should be valid" do
      expect(@user).to be_valid
    end

    it "name should be present" do
      @user.name = ' '
      expect(@user).not_to be_valid
    end

    it "email should be present" do
      @user.email = ' '
      expect(@user).not_to be_valid
    end

    it "name should not be too long" do
      @user.name = "a" * 31
      expect(@user).not_to be_valid
    end

    it "email should not be too long" do
      @user.email = "a" * 89 + "@example.com"
      expect(@user).not_to be_valid
    end

    it "email validation should accept valid addresses" do
      # %w[]で括弧内部の文字列を半角スペース区切りで配列化する
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end

    it "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end

    it "email addresses should be unique" do
      # dup オブジェクトの複製
      duplicate_user = @user.dup
      @user.save
      expect(duplicate_user).not_to be_valid
    end

    it "password should be present (nonblank)" do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).not_to be_valid
    end

    it "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).not_to be_valid
    end
  end
end
