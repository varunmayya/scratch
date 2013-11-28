class ScratchMailer < ActionMailer::Base
  default from: 'notification@scratchapp.in'
	#requires admin
  def send_scratch(to,from,data)
  	@data = data
  	@from = from
    mail(to: to ,subject: 'Scratch sent')
  end

  def new_user(to,from,data)
  	@data = data
  	@from = from
    mail(to: to ,subject: 'Join Scratch')
  end

end
