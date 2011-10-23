require 'spec_helper'

describe UsersController do
  render_views
  fixtures :users

  describe "GET 'index'" do

    describe "for non-logged-in users" do
      it "should deny access" do
        get "index"
        response.should redirect_to(login_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for logged-in users" do
      before(:each) do
        @user = users(:jon)
        second = users(:frodo)
        third = users(:samwise)
        @users = [@user, second, third]
        log_in(@user)
      end

      it "should be successful" do
        get "index"
        response.should be_success
      end

      it "should have the right title" do
        get "index"
        response.should have_selector("title", :content => "All users")
      end

      it "should have an element for each user" do
        get "index"
        @users.each do |user|
          response.should have_selector("li", :content => user.name)
        end
      end

    end

  end

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
      log_in(@user)
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
          :name => "Johnny H. Smith",
          :username => "jhsmith1",
          :password => "password",
          :password_confirmation => "password"
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

      it "should log in the user" do
        post "create", :user => @params
        session[:user_id].should_not be_nil
      end
    end

    describe "failure" do
      before(:each) do
        # Username already exists
        @params = {
          :name => "Johnny H. Smith",
          :username => "jhsmith",
          :password => "password",
          :password_confirmation => "password"
        }
      end

      it "should not create a user" do
        lambda do
          post "create", :user => @params
        end.should_not change(User, :count)
      end

      it "should not redirect" do
        post "create", :user => @params
        response.should_not be_redirect
      end

      it "should render the 'new' page" do
        post "create", :user => @params
        response.should render_template("new")
      end
    end

  end

  describe "GET 'edit'" do
    before(:each) do
      @user = User.first
      log_in(@user)
    end

    it "should be successful" do
      get "edit", :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get "edit", :id => @user
      response.should have_selector("title", :content => "Edit user")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = User.first
      log_in(@user)
    end

    describe "failure" do
      before(:each) do
        @params = {
          :name => "",
          :new_password => "",
          :password_confirmation => "",
        }
      end

      it "should render the 'edit' page" do
        put "update", :id => @user, :user => @params
        response.should render_template("edit")
      end

      it "should have the right title" do
        put "update", :id => @user, :user => @params
        response.should have_selector("title", :content => "Edit user")
      end
    end

    describe "success" do
      before(:each) do
        @params = {
          :name => "New name",
          :new_password => "newpassword",
          :password_confirmation => "newpassword",
        }
      end

      it "should change the user's attributes" do
        put "update", :id => @user, :user => @params
        @user.reload
        @user.name.should == @params[:name]
      end

      it "should redirect to the user show page" do
        put "update", :id => @user, :user => @params
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put "update", :id => @user, :user => @params
        flash[:success].should =~ /updated/
      end
    end

  end

  describe "authentication of show/edit/update pages" do
    before(:each) do
      @user = User.first
    end

    describe "for non-logged-in users" do

      it "should deny access to 'show'" do
        get "show", :id => @user
        response.should redirect_to(login_path)
      end

      it "should deny access to 'edit'" do
        get "edit", :id => @user
        response.should redirect_to(login_path)
      end

      it "should deny access to 'update'" do
        get "update", :id => @user, :user => {}
        response.should redirect_to(login_path)
      end
    end
  end

  describe "authorization of edit/update pages" do
    before(:each) do
      @user = users(:frodo)
      wrong_user = users(:samwise)
      log_in(wrong_user)
    end

    it "should require matching users for 'edit'" do
      get "edit", :id => @user
      response.should redirect_to(root_path)
    end

    it "should require matching users for 'update'" do
      get "update", :id => @user, :user => {}
      response.should redirect_to(root_path)
    end
  end

end
