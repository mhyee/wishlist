require 'spec_helper'

describe "Users" do
  fixtures :users

  describe "signup" do

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",                   :with => ""
          fill_in "Username",               :with => ""
          fill_in "Password",               :with => ""
          fill_in "Password confirmation",  :with => ""
          click_button

          response.should render_template("users/new")
          response.should have_selector("#error_messages")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",                   :with => "Example User"
          fill_in "Username",               :with => "example"
          fill_in "Password",               :with => "password"
          fill_in "Password confirmation",  :with => "password"
          click_button

          response.should have_selector(".flash.success", :content => "Signed up")
        end.should change(User, :count).by(1)
      end
    end

  end

  describe "log in/log out" do

    describe "failure" do
      it "should not log a user in" do
        visit login_path
        fill_in :username,   :with => ""
        fill_in :password,   :with => ""
        click_button

        response.should have_selector(".flash.alert", :content => "Invalid")
      end
    end

    describe "success" do
      it "should log in and log out a user" do
        user = User.first
        visit login_path
        fill_in :username,   :with => user.username
        fill_in :password,   :with => "password"
        click_button

        session[:user_id].should == user.id
        click_link "Log out"
        session[:user_id].should be_nil
      end
    end
  end

end
