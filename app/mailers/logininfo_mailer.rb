class LogininfoMailer < ActionMailer::Base
  default from: "enpit.s04@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.logininfo_mailer.registration_confirmation.subject
  #
  def registration_confirmation(resource)
    @user_id=resource.id
    mail to: resource.email
  end
end
