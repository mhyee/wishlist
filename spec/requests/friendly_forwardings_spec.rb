require 'spec_helper'

describe "FriendlyForwardings" do
  fixtures :users

  it "should forward to the requested page after login" do
    user = users(:jon)
    visit edit_user_path(user)
    # We get redirected to the login page
    fill_in :username,  :with => user.username
    fill_in :password,  :with => "password"
    click_button
    # We get redirected again
    response.should render_template('users/edit')
  end

end
