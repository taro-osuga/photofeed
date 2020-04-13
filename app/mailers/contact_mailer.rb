class ContactMailer < ApplicationMailer
    def contact_mail(feed)
        @feed = feed
        mail to: @feed.user.email, subject: "お問い合わせの確認メール"
      end
end
