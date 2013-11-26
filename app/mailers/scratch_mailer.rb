class ScratchMailer < ActionMailer::Base
  default from: 'notification@example.com'
	#requires admin
  def send_scratch(user)
    mail(to: user.email ,subject: 'Scratch sent')
  end

end
