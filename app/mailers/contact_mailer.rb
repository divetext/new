class ContactMailer < ApplicationMailer
    def contact_email(contact)
        @contact = contact
        mail to: contact.email, subject: "お問い合わせありがとうございます！"
    end
end
