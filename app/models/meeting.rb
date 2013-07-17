class Meeting < ActiveRecord::Base
  belongs_to :student
  belongs_to :instructor
  attr_accessible :day, :week, :instructor_id, :student_id

  def day_name
    names = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    names[day-1]
  end

# self.includes is true eagerly loading really loads everything instead of self.joins
# self.joins is an inner join

  def self.cached_meeting_eagerly
      Rails.cache.fetch([self, "all_meetings"])
      { self.includes(:student, :instructor).select("meetings.*, students.name, instructors.name").all }
  end

end
