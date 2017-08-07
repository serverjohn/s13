require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = FactoryGirl.build(:user)
    visit "/login"
    click_link "password"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    page.should have_content("Email sent")
    last_email.to.should include(user.email)
  end
end