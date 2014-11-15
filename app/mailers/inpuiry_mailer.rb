class InpuiryMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.inpuiry_mailer.received_email.subject
  #
  def received_email
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
