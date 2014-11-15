require "rails_helper"

RSpec.describe InquiryMailer, :type => :mailer do
  describe "received_email" do
    let(:mail) { InquiryMailer.received_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Received email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
