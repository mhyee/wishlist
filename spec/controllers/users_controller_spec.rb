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

    describe "success" do
      before(:each) do
        @params = {
          "name" => "Johnny H. Smith",
          "username" => "jhsmith1",
          "password" => "password",
          "password_confirmation" => "password"
        }
      end

      it "should create a user" do
        lambda do
          post "create", :user => @params
        end.should change(User, :count).by(1)
      end

      it "should redirect on successful registration" do
        post "create", :user => @params
        response.should be_redirect
      end

      it "should have a welcome message" do
        post "create", :user => @params
        flash[:success].should =~ /signed up/i
      end
    end

    describe "failure" do
      before(:each) do
        @params = {
          "name" => "Johnny H. Smith",
          "username" => "jhsmith",
          "password" => "password",
          "password_confirmation" => "password"
        }
      end

      it "should not create a user" do
        lambda do
          post "create", :user => @params
        end.should_not change(User, :count)
      end

      it "should not redirect" do
        user = mock_model(User, @params)

        User.should_receive(:new).with(@params).and_return(user)
        user.should_receive(:save).and_return(false)

        post "create", :user => @params
        response.should_not be_redirect
      end

      it "should render the 'new' page" do
        post "create", :user => @params
        response.should render_template("new")
      end
    end

  end

end
