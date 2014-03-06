require "spec_helper"

describe "A user" do

  it "requires a name" do
    user = build(:user, name: "")

    expect(user.valid?).to be_false
    expect(user.errors[:name].any?).to be_true
  end

  it "requires a username" do
    user = build(:user, username: "")

    expect(user.valid?).to be_false
    expect(user.errors[:username].any?).to be_true
  end

  it "requires a unique, case insensitive username" do
    user1 = create(:user, username: "same")
    user2 = build(:user, username: "same")

    expect(user2.valid?).to be_false
    expect(user2.errors[:username].first).to eq("has already been taken")
  end

  it "requires an email" do
    user = build(:user, email: "")

    expect(user.valid?).to be_false
    expect(user.errors[:email].any?).to be_true
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com]
    emails.each do |email|
      user = build(:user, email: email)

      expect(user.valid?).to be_true
      expect(user.errors[:email].any?).to be_false
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      user = build(:user, email: email)

      expect(user.valid?).to be_false
      expect(user.errors[:email].any?).to be_true
    end
  end

  it "automatically encrypts the password into the password_digest attribute" do
    user = build(:user, password: "secret")

    expect(user.password_digest).to be_present
  end

  it "it requires a unique, case insensitive email addresses" do
    user1 = create(:user)
    user2 = build(:user, email: user1.email.upcase)

    expect(user2.valid?).to be_false
    expect(user2.errors[:email].first).to eq("has already been taken")
  end

  it "is valid with factory attributes" do
    user = build(:user)

    expect(user.valid?).to be_true
  end

  it "requires a password" do
    user = build(:user, password: "")

    expect(user.valid?).to be_false
    expect(user.errors[:password].any?).to be_true
  end

  it "requires a minimum 6 chars length password" do
    user = build(:user, password: "two")

    expect(user.valid?).to be_false
    expect(user.errors[:password].first).to eq("is too short (minimum is 6 characters)")
  end

  it "requires a password confirmation when a password is present" do
    user = build(:user, password: "secret", password_confirmation: "")

    expect(user.valid?).to be_false
    expect(user.errors[:password_confirmation].any?).to be_true
  end

  it "requires the password to match the password confirmation" do
    user = build(:user, password: "secret", password_confirmation: "nomatch")

    expect(user.valid?).to be_false
    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end

  it "requires a password and matching password confirmation when creating" do
    user = build(:user, password: "secret", password_confirmation: "secret")

    expect(user.valid?).to be_true
  end

  it "does not require a password when updating" do
    user = create(:user)

    user.password = ""

    expect(user.valid?).to be_true
  end
end
