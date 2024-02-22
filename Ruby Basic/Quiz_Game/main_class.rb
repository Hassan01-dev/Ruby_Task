class Main_menu
  def menu
    quiz = Quiz.new                             #Object of quiz to perform certain methods in Quiz class
    puts 'Quiz Games!'
    print "Press Enter to continue : "
    gets
    system "clear"
    puts "1 => Start Quiz (Simple)"
    puts "2 => Start Quiz (Shuffle)"
    puts "3 => Custamization"
    puts "4 => End Program"

    sel_option = gets.to_i
    case sel_option
    when 1
      #When user select to start quiz simple
      quiz.start_quiz(false)
    when 2
      #When user select to start quiz wiht shuffle questions
      quiz.start_quiz(true)
    when 3
      #When user want to custamize the quiz
      quiz.custamize_quiz
    when 4
      puts "Ending Program ..."
    else
      puts "Invalid Input Program closed"
    end
  end
end
