require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validations" do
    it "should have comment" do
      should have_db_column(:comments).of_type(:string)
    end

    describe "validates presence of attributes" do
      it { is_expected.to validate_presence_of(:comments) }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end
end
