require 'spec_helper'

describe UsersController do
  render_views
  fixtures :users

  describe "GET 'new'" do
    it "should be successful" do
      get "new"
      response.should be_success
    end

    it "should have the right title" do
      get "new"
      response.should have_selector("title", :content => "Sign up")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = User.first
    end

    it "should be successful" do
      get "show", :id => @user
      response.should be_success
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get "show", :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get "show", :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
  end

  describe "POST 'create'" do
    it "should redirect on successful registration" do
      params = {
        "name" => "Johnny H. Smith",
        "username" => "jhsmith1",
        "password" => "password",
        "password_confirmation" => "password"
      }
      user = mock_model(User, params)

      User.should_receive(:new).with(params).and_return(user)
      user.should_receive(:save).and_return(true)

      post "create", :user => params
      response.should be_redirect
    end

    it "should not redirect on unsuccessful registration" do
      params = {
        "name" => "Johnny H. Smith",
        "username" => "jhsmith",
        "password" => "password",
        "password_confirmation" => "password"
      }
      user = mock_model(User, params)

      User.should_receive(:new).with(params).and_return(user)
      user.should_receive(:save).and_return(false)

      post "create", :user => params
      response.should_not be_redirect
    end
  end

end
