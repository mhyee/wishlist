require 'spec_helper'

describe "LayoutLinks" do
  fixtures :users

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a Signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

  it "should have a Login page at '/login'" do
    get '/login'
    response.should have_selector('title', :content => "Log in")
  end

  describe "when not logged in" do
    it "should have a log in link" do
      visit root_url
      response.should have_selector("a", :href => login_path, :content => "Log in")
    end

    it "should have a signup link" do
      visit root_url
      response.should have_selector("a", :href => signup_path, :content => "Sign up")
    end
  end

  describe "when logged in" do
    before(:each) do
      @user = User.first
      visit login_path
      fill_in :username,  :with => @user.username
      fill_in :password,  :with => "password"
      click_button
    end

    it "should have a users link" do
      visit root_url
      response.should have_selector("a", :href => users_path, :content => "Users")
    end

    it "should have an edit account link" do
      visit root_url
      response.should have_selector("a", :href => edit_user_path(@user), :content => "Edit account")
    end

    it "should have a logout link" do
      visit root_url
      response.should have_selector("a", :href => logout_path, :content => "Log out")
    end
  end
end
