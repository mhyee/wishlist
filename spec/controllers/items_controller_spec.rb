require 'spec_helper'

describe ItemsController do
  render_views
  fixtures :users, :lists

  describe "GET 'new'" do
    before(:each) do
      @user = User.first
      log_in(@user)
    end

    it "should be successful" do
      get "new"
      response.should be_success
    end

    it "should have the right title" do
      get "new"
      response.should have_selector("title", :content => "New Item")
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user = User.first
      log_in(@user)
    end

    describe "success" do
      before(:each) do
        @params = {
          :title => "The One Ring",
          :description => "One Ring to Rule Them All!"
        }
      end

      it "should create an item" do
        lambda do
          post "create", :item => @params
        end.should change(Item, :count).by(1)
      end

      it "should redirect on successful creation" do
        post "create", :item => @params
        response.should be_redirect
      end

      it "should have a notice" do
        post "create", :item => @params
        flash[:success].should =~ /item added/i
      end

    end

    describe "failure" do
      before(:each) do
        # No title passed
        @params = {
          :description => "One Ring to Rule Them All!"
        }
      end

      it "should not create an item" do
        lambda do
          post "create", :item => @params
        end.should_not change(Item, :count)
      end

      it "should not redirect" do
        post "create", :item => @params
        response.should_not be_redirect
      end

      it "should render the 'new' page" do
        post "create", :item => @params
        response.should render_template("new")
      end
    end

  end

end
