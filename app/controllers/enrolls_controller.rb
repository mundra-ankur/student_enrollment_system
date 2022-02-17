class EnrollsController < ApplicationController
  before_action :set_enroll, only: %i[show edit update destroy]
  before_action :authenticate_member!

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
    @enroll.student = current_student || Student.find_by(student_id: params[:student_id])
    @enroll.course_id = params[:course_id]

    @enrolls = Enroll.all
    found = Enroll.where(student_id: params[:student_id], course_id: params[:course_id])
    if found != []
      puts '===================STUDENT ALREADY ENROLLED======================='
      redirect_to student_root_path, notice: 'STUDENT ALREADY ENROLLED.'
      return
    end

    @course = Course.find(params[:course_id])
    if @course[:status] == 'CLOSED'
      puts '===================Course is CLOSED - Enrollment was not done======================='
      redirect_back fallback_location: student_root_path, notice: 'Course is CLOSED - Enrollment was not done.'
      return
    end

    if @course[:capacity] > 1
      @course[:capacity] -= 1
    elsif @course[:capacity] == 1 && @course[:waitlist_capacity] != nil
      @course[:capacity] -= 1
      @course.status = 'WAITLIST'
    elsif @course[:capacity] == 1 && @course[:waitlist_capacity] == nil
      @course[:capacity] -= 1
      @course.status = 'CLOSED'
    elsif(@course[:capacity] == 0 && @course[:waitlist_capacity] > 1)
      @course[:waitlist_capacity] -= 1
      @course[:status] = 'WAITLIST'
      @enroll[:waitlist] = 'TRUE'
    elsif(@course[:capacity] == 0 && @course[:waitlist_capacity] == 1)
      @course[:waitlist_capacity] -= 1
      @course[:status] = 'CLOSED'
      @enroll[:waitlist] = 'TRUE'
    end
    @course.save

    if @enroll.save && @enroll[:waitlist] == 'TRUE'
      if admin_signed_in?
        redirect_back fallback_location: admin_students_path, notice: "Successfully waitlisted in #{@course.name}!"
      else
        redirect_back fallback_location: student_root_path, notice: "Successfully waitlisted in #{@course.name}!"
      end
    elsif @enroll.save
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
    if @course[:status] == 'OPEN'
      @course[:capacity] += 1

    elsif @course[:status] == 'CLOSED' && @course[:waitlist_capacity] == nil
      @course[:status] = 'OPEN'
      @course[:capacity] += 1
    elsif @course[:status] == 'CLOSED' && @course[:waitlist_capacity] != nil && @enroll.waitlist == nil
      @course[:status] = 'WAITLIST'
      @course[:waitlist_capacity] += 1
      if @enroll.waitlist == nil
        @waitlistedstudent = Enroll.where(course_id: @enroll.course_id, waitlist: 'TRUE').order(:created_at).first # ruby
        if @waitlistedstudent != nil
          @waitlistedstudent[:waitlist] = nil
          @waitlistedstudent.save
        end
      end
    elsif @course[:status] == 'CLOSED' && @course[:waitlist_capacity] != nil && @enroll[:waitlist] == 'TRUE'
      @course[:status] = 'WAITLIST'
      @course[:waitlist_capacity] += 1

    elsif @course[:status] == 'WAITLIST' && @course[:waitlist_capacity] != nil && @enroll[:waitlist] == nil
      @waitlistedstudent = Enroll.where(course_id: @enroll.course_id, waitlist: 'TRUE').order(:created_at).first # ruby
      if @waitlistedstudent != nil
        @waitlistedstudent[:waitlist] = nil
        @waitlistedstudent.save
        @course[:waitlist_capacity] += 1
        @course[:status] = 'WAITLIST'
      else
        @course[:capacity] += 1
        @course[:status] = 'OPEN'
      end
    elsif @course[:status] == 'WAITLIST' && @course[:waitlist_capacity] != nil && @enroll[:waitlist] == 'TRUE'
      @course[:status] = 'WAITLIST'
      @course[:waitlist_capacity] += 1
    end

    @course.save
    @enroll.destroy
    if admin_signed_in?
      redirect_back fallback_location: admin_students_url, notice: "Enrollment for #{@course.name} is dropped!"
    else
      redirect_back fallback_location: root_path, notice: "Enrollment for #{@course.name} is dropped!"
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