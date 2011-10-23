require 'spec_helper'

describe SessionsController do
  render_views
  fixtures :users

  describe "GET 'new'" do
    it "should be successful" do
      get "new"
      response.should be_success
    end

    it "should have the right title" do
      get "new"
      response.should have_selector("title", :content => "Log in")
    end
  end

  describe "POST 'create'" do

    describe "invalid login" do
      before(:each) do
        @params = { :username => "foobar", :password => "password" }
      end

      it "should re-render the 'new' page" do
        post "create", :session => @params
        response.should render_template("new")
      end

      it "should have the right title" do
        post "create", :session => @params
        response.should have_selector("title", :content => "Log in")
      end

      it "should have a flash.now message" do
        post "create", :session => @params
        flash.now[:alert].should =~ /invalid/i
      end
    end

    describe "with valid username and password" do
      before(:each) do
        @user = User.first
        @params = { :username => @user.username, :password => "password" }
      end

      it "should sign the user in" do
        post "create", :session => @params
        session[:user_id].should == @user.id
      end

      it "should redirect after signing in" do
        post "create", :session => @params
        response.should be_redirect
      end
    end

  end

  describe "DELETE 'destroy'" do
    it "should sign a user out" do
      log_in(User.first)
      delete "destroy"
      session[:user_id].should be_nil
      response.should redirect_to(root_url)
    end
  end

end
