require "spec_helper"

describe Notifications do
  describe "new_renter" do
    let(:mail) { Notifications.new_renter }

    it "renders the headers" do
      mail.subject.should eq("New renter")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "access_to_renter" do
    let(:mail) { Notifications.access_to_renter }

    it "renders the headers" do
      mail.subject.should eq("Access to renter")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
