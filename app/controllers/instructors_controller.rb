class InstructorsController < ApplicationController
  before_action :authenticate_instructor!

  def index
    if current_instructor.id != nil
      @courses = Course.where(instructor_id: current_instructor.id)
    else
      @courses = nil
    end
  end
end
