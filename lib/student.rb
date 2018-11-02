require_relative "../config/environment.rb"

class Student
  attr_reader :id, :name, :grade

  def initialize(name, grade)
    @id = nil
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
  end
end
