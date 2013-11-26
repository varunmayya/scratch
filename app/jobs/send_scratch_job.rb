class SendScratchJob
	
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(user)
    ScratchMailer.send_scratch(user).deliver
  end

end