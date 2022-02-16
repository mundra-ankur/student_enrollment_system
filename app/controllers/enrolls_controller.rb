class EnrollsController < ApplicationController
  before_action :set_enroll, only: %i[show edit update destroy]

  # GET /enrolls
  def index
    @enrolls = Enroll.all
  end

  # GET /enrolls/1
  def show
    @enrolls = Enroll.all
  end

  # GET /enrolls/new
  def new
    @enroll = Enroll.new
  end

  # GET /enrolls/1/edit
  def edit
  end

  # POST /enrolls
  def create
    @enroll = Enroll.new
    # @enroll.student_id = current_student.student_id || params[:id]
    puts "Collllllll ----->>>>>>>> #{params}"
    @enroll.student = current_student || Student.find_by(student_id: params[:student_id])
    @enroll.course_id = params[:course_id]

    @course = Course.find(params[:course_id])
    if @course[:capacity] <= 0
      # redirect_to @student, notice: "Course is FULL - Enrollment was not done."
      puts '===================Course is FULL - Enrollment was not done======================='
      # render :new, status: :unprocessable_entity
      redirect_to student_root_path, notice: 'Course is FULL - Enrollment was not done.'
      return
    elsif @course[:status] == 'closed'
      puts '===================Course is CLOSED - Enrollment was not done======================='
      # render :new, status: :unprocessable_entity
      redirect_to student_root_path, notice: 'Course is CLOSED - Enrollment was not done.'
      return
    end

    @enrolls = Enroll.all
    found = Enroll.where(student_id: params[:student_id], course_id: params[:course_id])
    if found != []
      puts '===================STUDENT ALREADY ENROLLED======================='
      redirect_to student_root_path, notice: 'STUDENT ALREADY ENROLLED.'
      return
    end

    @course[:capacity] -= 1
    if (@course[:capacity]).zero?
      @course[:status] = 'CLOSED'
    end
    @course.save
    puts "course is #{@course[:code]}#{@course[:name]} CAPACITY IS #{@course[:capacity]} STATUS IS #{@course[:status]}"

    if @enroll.save
      if admin_signed_in?
        redirect_back fallback_location: admin_students_path, notice: "Successfully enrolled in #{@course.name}!"
      else
        redirect_back fallback_location: student_root_path, notice: "Successfully enrolled in #{@course.name}!"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /enrolls/1
  def update
    @course = Course.find(params[:course_id])
    @course[:capacity] += 1
    @course.save

    if @enroll.update(enroll_params)
      redirect_to @enroll, notice: 'Enroll was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /enrolls/1
  def destroy
    if @enroll.nil?
      puts '===================STUDENT NOT ENROLLED======================='
      redirect_to student_root_path, notice: 'STUDENT NOT ENROLLED.'
      return
    end
    @course = Course.find(@enroll[:course_id])
    @course[:capacity] += 1
    @course.save

    @enroll.destroy
    if admin_signed_in?
      redirect_to admin_students_url, notice: "#{@course.name} is dropped!"
    else
      redirect_to enrolls_url, notice: "#{@course.name} is dropped!"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_enroll
    @enroll = Enroll.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  #   def enroll_params
  #     params.require(:enroll).permit(:student_id, :course_id)
  #   end
end
