class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :authenticate_instructor!, except: %i[show]

  # GET /courses
  def index
    if current_instructor != nil
      @courses = Course.where(instructor_id: current_instructor.id)
    else
     @courses = Course.all
    end
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    @instructor = current_instructor
  end

  # GET /courses/1/edit
  def edit
    @instructor = current_instructor
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @course.instructor = current_instructor
    if @course.save
      redirect_to @course, notice: "Course was successfully created."
    else
      @instructor = current_instructor
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: "Course was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find_by_code(params[:id])
      if @course.nil?
        redirect_to courses_url, notice: "Course #{params[:id]} not there!"
      end
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :description, :instructor_name, :weekday1, :weekday2, :start_time, :end_time, :code, :capacity, :waitlist_capacity, :status, :room, :instructor_id)
    end
end
