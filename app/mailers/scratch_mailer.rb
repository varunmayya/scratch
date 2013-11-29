class ScratchMailer < ActionMailer::Base
  default from: 'notification@scratchapp.in'
	#requires admin
  def send_scratch(to,from,data)
  	@data = data
  	@from = from
    mail(to: to ,subject: 'You\'ve received a scratch!')
  end

  def new_user(to,from,data)
  	@data = data
  	@from = from
    mail(to: to ,subject: 'You\'ve received an invitation to Scratch!')
  end

end
