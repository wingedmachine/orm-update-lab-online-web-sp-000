require_relative "../config/environment.rb"

class Student
  attr_reader :id, :name, :grade

  def initialize
    @id = nil
  end
end
