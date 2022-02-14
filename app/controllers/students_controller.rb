class StudentsController < ApplicationController
  before_action :authenticate_student!

  def home
    if current_student.id != nil
      @courses = Course.all
      @student = Student.find(current_student.id)
    else
      @courses = nil
    end
  end
end
