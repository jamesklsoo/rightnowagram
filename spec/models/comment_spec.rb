require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validations" do
    it "should have comment" do
      should have_db_column(:contents).of_type(:string)
    end

    describe "does not validates presence of attributes" do
      it { should_not validate_presence_of(:contents) }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end
end
