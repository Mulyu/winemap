class InquiryMailer < ActionMailer::Base
  default from: 'enpit.s04@gmail.com'
  default to: 'enpit.s04@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.inquiry_mailer.received_email.subject
  #
  def received_email
    @inquiry = inquiry
    mail(subject: 'お問い合わせがありました')
  end
end
