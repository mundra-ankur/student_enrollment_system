class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index; end

  def instructors
    @instructors = Instructor.all
  end
end
