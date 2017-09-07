require 'rails_helper'


RSpec.describe "welcome/index.html.erb", type: :feature do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a link to register for account" do
    visit "/"
    click_link("Sign Up")
    expect(page.current_path).to eq("/users/new")
  end

  it "has a link to go to homepage" do
    visit "/"
    click_link("Rightnowagram")
    expect(page.current_path).to eq("/")
  end
end
