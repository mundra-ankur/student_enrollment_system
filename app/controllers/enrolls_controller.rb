class EnrollsController < ApplicationController
  before_action :set_enroll, only: %i[ show edit update destroy ]

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
    debugger
    @enroll = Enroll.new()
    @enroll.student_id = current_student.student_id
    @enroll.course_id = params[:course_id]

    if @enroll.save
      redirect_to @enroll, notice: "Enroll was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /enrolls/1
  def update
    if @enroll.update(enroll_params)
      redirect_to @enroll, notice: "Enroll was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /enrolls/1
  def destroy
    @enroll.destroy
    redirect_to enrolls_url, notice: "Enroll was successfully destroyed."
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
