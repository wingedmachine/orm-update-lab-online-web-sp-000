require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save
    if id
      update
    else
      sql = <<-SQL
        INSERT INTO students (name, grade) VALUES ( ?, ?)
      SQL

      DB[:conn].execute(sql, name, grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end

  def self.create(name, grade)
    student = Student.new(name, grade)
    student.save
    student
  end

  def self.new_from_db(row)
    Student.new(row[1], row[2], row[0])
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
    SQL

    row = DB[:conn].execute(sql, name)
    ret = Student.new_from_db(row.first)
    binding.pry
    ret
  end

  def update
    sql = <<-SQL
      UPDATE students
      SET name = ?,
          grade = ?
      WHERE id = ?
    SQL

    DB[:conn].execute(sql, name, grade, id)
  end
end
