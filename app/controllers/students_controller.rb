class StudentsController < ApplicationController
  before_action :authenticate_student!

  def index
    if current_student.nil?
      @courses = nil
    else
      enrolled_course_code = Enroll.where(student_id: current_student.id).pluck(:course_id)
      @courses = Course.where.not(code: enrolled_course_code)
      @student = current_student
      @enrolled_courses = Course.where(code: enrolled_course_code)
    end
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
