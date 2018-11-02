require_relative "../config/environment.rb"

class Student
  attr_reader :id, :name, :grade

  def initialize(name, grade)
    @id = nil
    @name = name
    @grade = grade
  end
end
