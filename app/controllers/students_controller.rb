class StudentsController < ApplicationController
  before_action :authenticate_student!

  def home
  end
end
