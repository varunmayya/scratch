class SendScratchJob
	
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(to,from,data,isuser)
  	if isuser
    	ScratchMailer.send_scratch(to,from,data).deliver
    else
    	ScratchMailer.new_user(to,from,data).deliver
    end
  end

end