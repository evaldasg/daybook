require "spec_helper"

describe "Viewing the list of users" do

  it "shows the users" do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)

    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end

end
