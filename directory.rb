require "CSV"
@students = []

def interactive_menu
  loop do
    print_menu
    option(STDIN.gets.chomp)
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    add_students(name, cohort = "November")
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit"
end

def show_students
    print_header
    print_student_list
    print_footer
end

def option(selection)
  case selection
  when "1" then puts "You selected 'add students'"
    input_students
  when "2" then puts "You selected 'show students'"
    show_students
  when "3" then puts "You selected 'save students'"
    save_students
  when "4" then puts "You selected 'load students'"
    load_students
  when "9" then puts 'Exiting'
    exit
  else puts "I don't know what you meant, please try again"
  end
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  puts "Please enter a filename or enter return to use default file"
  @filename = STDIN.gets.chomp
  save_file
end

def save_file
  if File.exists?(@filename)
    puts "Saved to '#{@filename}'"
    file = CSV.open((@filename), "w") do |csv|
    @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv << student_data
    end
    end
  else
    puts "Saved to 'students.csv'"
    file = CSV.open("students.csv", "w") do |csv|
    @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv << student_data
    end
    end
  end
end

def load_students(filename = "students.csv")
  puts "Please enter a filename or enter return to use default file"
  @filename = STDIN.gets.chomp
    if File.exists?(@filename)
      puts "Loaded from #{@filename}"
      load_file
    else
      puts "Loaded from 'students.csv'"
      @filename = "students.csv"
      load_file
    end
end

def load_file
  file = CSV.open(@filename, "r") do |csv|
  csv.readlines.each do |line|
  name, cohort = line
  add_students(name, cohort = "November")
  end
  end
end

def add_students(name, cohort = "November")
  @students << {name: name, cohort: cohort.to_sym}
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

try_load_students
interactive_menu

