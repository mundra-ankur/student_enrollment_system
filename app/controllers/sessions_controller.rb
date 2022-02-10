class SessionsController < ApplicationController
  def new
  end

  def create
    # debugger
    @student = Student.find_by_email(params[:student][:email])
    if @student && @student.authenticate(params[:student][:password])
      session[:student_id] = @student.id
      redirect_to @student
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def login
  end

  def welcome
  end
end
