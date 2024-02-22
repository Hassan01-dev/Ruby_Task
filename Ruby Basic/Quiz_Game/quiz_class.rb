class Quiz
  attr_accessor :timer, :file_name

  # Setting the default value of the variable in the constructor of class
  def initialize()
    @timer = 30
    @file_name = "problems.csv"
  end

  #Function which contain the main implementation of quiz
  # Here correct_ans is used to store the number of correct answer whihch user gave
  # Here attempted is used to store the number of question attempted by user
  # Here questions contain all the question and answer for the quiz
  def start_quiz(shuffle = false)
    correct_ans = 0
    attempted = 0
    questions = get_questions(@file_name)
    system "clear"
    puts "Press Enter to Start the Quiz ....."
    gets

    #To shuffle the question when the user select the option quiz with shuffle
    if shuffle
      questions.shuffle!()
    end

    #Thread in which the quiz is happening
    user_input = Thread.new do
      questions.each do |question|
        system "clear"
        print question[0] + " = "
        ans = gets.chomp
        attempted += 1
        if ans.to_i == question[1].to_i
          correct_ans += 1
        end
      end
    end

    #Thread to stop user from carry on with the quiz when the time limit exceed
    Thread.new { sleep timer; user_input.kill; puts }

    #Joing the thread
    user_input.join

    #This function will output the report on to the console
    generate_report(correct_ans, questions.length, attempted)
  end

  #Function to read the csv file and return the array of questions and answers to main program
  def get_questions(file_name)
    questions = CSV.readlines(file_name)
    questions
  end

  #Function to create the final reprt after the time ended or user completed attempting all the questions
  def generate_report(correct, total, attempted)
    puts "Final Report of Quiz Game"
    puts "Total Questions : #{total}"
    puts "Attempted Questios : #{attempted}"
    puts "Correct Answers : #{correct}"
    puts "Wrong Answers : #{attempted-correct}"
  end

  #Function to gave user some authority if user want to change the time for quiz or the question/answer file
  def custamize_quiz
    system "clear"
    puts "Welcome to Quiz Custamization"
    puts "1 => Update Timer"
    puts "2 => Change File"
    puts "3 => Start Quiz"

    sel_option = gets.to_i
    case sel_option
    when 1
      print "Enter the Time for Quiz : "
      @timer = gets.to_i
      custamize_quiz
    when 2
      print "Enter the name of New File : "
      @file_name = gets.chomp
      custamize_quiz
    when 3
      start_quiz
    else
      puts "Invalid Input Program closed"
    end
  end
end
