class Mailer < ActionMailer::Base  
  def contact_mail(sender)
     recipients "ben@eexistence.de"
     #bcc        ["bcc@example.com", "Order Watcher <watcher@example.com>"]
     from       "Website Contact Request <root@eexistence.de>"
     reply_to   sender['email']
     subject    "New Contact Mail"
     body       sender['message']
   end
end
