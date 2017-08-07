require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do

    it "should have all specific attributes" do
      should have_db_column(:fullname).of_type(:string)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:password_digest).of_type(:string)
      should have_db_column(:website).of_type(:string)
      should have_db_column(:bio).of_type(:string)
      should have_db_column(:gender).of_type(:integer)
      should have_db_column(:phone_num).of_type(:integer)
      should have_db_column(:avatar).of_type(:json)
    end

    describe "validates presence of attributes" do
      it { is_expected.to validate_presence_of(:fullname)}
      it { is_expected.to validate_presence_of(:email)}
      it { is_expected.to validate_presence_of(:password)}
    end

    describe "validates valid email and password" do
      it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(20) }
    end

    #happy_path
    describe "can be created when all attributes are present" do
      When(:user) { User.create(
                      fullname: "Apple",
                      email: "abc@gmail.com",
                      password: "123456",
      )}
      Then { user.valid? == true }
    end

    # unhappy_path
    describe "cannot be created without fullname" do
      When(:user) { User.create(email: "abc@gmail.com", password: "123456") }
      Then { user.valid? == false }
    end


    describe "cannot be created without a email" do
      When(:user) { User.create(password: "123456", fullname: "Apple") }
      Then { user.valid? == false }
    end

    describe "cannot be created without a password" do
      When(:user) { User.create(email: "abc@gmail.com", fullname: "Apple") }
      Then { user.valid? == false }
    end

    describe "should permit valid email only" do
      let(:user1) { User.create(fullname: "Apple", email: "abc@gmail.com", password: "123456")}
      let(:user2) { User.create(fullname: "Pear",email: "pear.com", password: "123456") }

      # happy_path
      it "sign up with valid email" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid email" do
        expect(user2).to be_invalid
      end
    end
  end

  context 'associations with dependency' do
    it { is_expected.to have_many(:authentications).dependent(:destroy)}
    it { is_expected.to have_many(:posts)}
    it { is_expected.to have_many(:comments)}
    it { is_expected.to have_many(:likes)}
    it { is_expected.to have_many(:buyings)}
  end
end
