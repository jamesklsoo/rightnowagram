require 'rails_helper'


RSpec.describe "posts/index.html.erb", type: :feature do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a link to register for account" do
    visit "/posts"
    click_link("Register")
    expect(page.current_path).to eq("/users/new")
  end

  it "has a link to go to homepage" do
    visit "/posts"
    click_link("Rightnowagram")
    expect(page.current_path).to eq("/")
  end
end
