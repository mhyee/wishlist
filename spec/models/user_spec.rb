require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Foo S. Bar",
      :username => "foobar",
      :password => "foobarpassword",
      :password_confirmation => "foobarpassword"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    User.new(@attr.merge(:name => "")).should_not be_valid
  end

  describe "username validations" do
    it "should require a username" do
      User.new(@attr.merge(:username => "")).should_not be_valid
    end

    it "should reject short usernames" do
      User.new(@attr.merge(:username => "Q")).should_not be_valid
    end

    it "should reject long usernames" do
      User.new(@attr.merge(:username => "A" * 33)).should_not be_valid
    end

    it "should reject duplicate usernames" do
      User.create!(@attr)
      User.new(@attr).should_not be_valid
    end

    it "should reject duplicate usernames (with different cases)" do
      upcase_username = @attr[:username].upcase
      User.create!(@attr)
      User.new(@attr.merge(:username => upcase_username)).should_not be_valid
    end
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should reject short passwords" do
      password = "A" * 7
      User.new(@attr.merge(:password => password,
        :password_confirmation => password)).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "notmatching")).should_not be_valid
    end
  end

  describe "admin attribute" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

end
