class RequestMailer < ActionMailer::Base
  #default from: "from@example.com"
  def send_request(request_email, package_type, email_to)
    @request_email = request_email
    @package_type = package_type
    mail(:to => email_to, :subject => "#{request_email.split('@').first} Requested to Sign Up", :from => "#{request_email.split('@').first} <#{request_email}>")
  end
end
