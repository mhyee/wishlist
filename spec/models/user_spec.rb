require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "John Smith",
      :username => "jsmith",
      :password => "foobarpassword"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a username" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
  end

  it "should require a password" do
    no_password_user = User.new(@attr.merge(:password => ""))
    no_password_user.should_not be_valid
  end

  it "should reject usernames that are too short" do
    short_name = "Q"
    short_name_user = User.new(@attr.merge(:username => short_name))
    short_name_user.should_not be_valid
  end

  it "should reject usernames that are too long" do
    long_name = "A" * 33
    long_name_user = User.new(@attr.merge(:username => long_name))
    long_name_user.should_not be_valid
  end

  it "should reject passwords that are too short" do
    short_password = "A" * 7
    short_password_user = User.new(@attr.merge(:password => short_password))
    short_password_user.should_not be_valid
  end

  it "should reject duplicate usernames" do
    User.create!(@attr)
    duplicate_user = User.new(@attr)
    duplicate_user.should_not be_valid
  end

  it "should reject duplicate usernames (with different cases)" do
    upcase_username = @attr[:username].upcase
    User.create!(@attr)
    duplicate_user = User.new(@attr.merge(:username => upcase_username))
    duplicate_user.should_not be_valid
  end
end
