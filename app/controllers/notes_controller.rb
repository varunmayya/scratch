class NotesController < ApplicationController
  before_action :hijack, only: [:create]
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:new,:policy]
  before_action :check_if_my_notes, only: [ :show, :edit, :update, :destroy]
  # GET /notes
  # GET /notes.json
  def index
    @notes = current_user.notes.order("created_at DESC")
    respond_to do |format|
      format.html
      format.xml
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

def hijack
  unless user_signed_in?
      session[:pre_login] = params[:note][:data]
  end
end

def aprocess
  current_user.notes.create(data: session[:pre_login]) unless session[:pre_login].blank?
  session[:pre_login] = nil
  redirect_to notes_url
end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_path, notice: 'Note was successfully created.' }
        format.json { render action: 'index', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  def policy
  end

  def sendit
    @note = Note.find_by_id(params[:note_id])

    unless params[:email].match /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
      redirect_to request.referer, notice: "Invalid email!" and return
    end

    unless @note
      redirect_to request.referer, notice: "Oops. Something went wrong!" and return
    end

    unless current_user.notes.include?(@note)
      redirect_to request.referer, notice: "Oops. Something went wrong!" and return
    end
    
    new2 = User.find_by_email(params[:email])

    if new2
      new2.notes.create(:data => @note.data, :sent_by_id => current_user.id)
      #send already existing mail
      send_mail(params[:email],current_user.email,@note.data,true)
      redirect_to request.referer, notice: "Note sent sucessfully to user's inventory."
    else
      #send advertisement mail
      send_mail(params[:email],current_user,@note.data,false)
      redirect_to request.referer, notice: "Note sent sucessfully to email."
    end

    
  end

  private

      require 'send_scratch_job'

      def send_mail(to,from,data,isuser)
        # We call our sucker punch job asynchronously using "async"
          ::SendScratchJob.new.async.perform(to,from,data,isuser)
      end

    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = current_user.notes.find(params[:id])
    end

    def check_if_my_notes
      if @note.user = current_user
      else
        redirect_to root_url, :notice => "Access denied."
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:data)
    end
end

