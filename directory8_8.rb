def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please enter cohort"
    cohort = gets.chomp
    # add the student hash to the array
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end


def print(students)
  sorted_by_cohort = {}
  students.each do |x|
    cohort = x[:cohort]
    name = x[:name]
    if sorted_by_cohort[cohort] == nil
      sorted_by_cohort[cohort] = [name]
    else
      sorted_by_cohort[cohort].push(name)
    end
  end
  sorted_by_cohort.each do |month, name|
      puts month.to_s.capitalize
      puts name
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)