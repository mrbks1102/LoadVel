class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(
      to: "rails111102@gmail.com",
      subject: "お問い合わせ通知"
    )
  end
end
