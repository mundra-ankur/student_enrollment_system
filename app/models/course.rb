class Course < ApplicationRecord
  belongs_to :instructor
  has_many :enrolls, dependent: :delete_all
  validates :code, presence: true, uniqueness: true
  validates :weekday1, presence: true, comparison: { other_than: :weekday2}
  validates :start_time, presence: true
  validates :end_time, presence: true , comparison: {greater_than: :start_time}

  def formatted_start_time
    self.start_time.strftime("%H:%M")
  end

  def formatted_end_time
    self.end_time.strftime("%H:%M")
  end
end
