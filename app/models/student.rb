class Student <ApplicationRecord
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :house

  has_many :professor_students
  has_many :professors, through: :professor_students

  def num_professors
    professors.count
  end

  def self.by_name
    order(:name)
  end
end
