class ContactMailer < ActionMailer::Base
  #default from: "from@example.com"
  def send_contact_message(name, email, subject, message)
    @message = message
    mail(:to => "support@credvine.com", :from => "#{name} <#{email}>", :subject => subject)
  end
end
