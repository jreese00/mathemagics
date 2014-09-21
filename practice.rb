require_relative "helpers.rb"

class Practice

  def initialize
    @main_menu = {:+ => "Addition", :- => "Subtraction", :* => "Multiplication", :/ => "Division", :! => "Complement"}
    @header = "What would you like to practice?"
    @type = nil
    @problem_count = 0
    @operand_length = 0
    @correct_responses = 0
    @incorrect_responses = 0
  end

  def run
    @practice_type = request_practice_type
    @operand_length = request_operand_length
    @total_problems = request_problem_count
    
    @total_problems.times do
      problem = generate_problem
      ask_problem(problem)
    end
  end

  def request_practice_type
    response = nil
    until @main_menu.has_key?(response) do
      print_menu(@main_menu, @header)
      response = gets.chomp.to_sym
    end
    return response
  end

  def request_problem_count
    return get_integer_input("How many problems would you like to solve? > ",0,100)
  end

  def request_operand_length
    return get_integer_input("What size operands would you like to use? > ",2,5)
  end

  def generate_operands
    min = 10**(@operand_length - 1)
    max = (10**@operand_length) - 1
    
    operands = [rand(min..max), rand(min..max)]
    # Order matters for subtraction and division
    operands.sort!.reverse! if [:-, :/].include?(@practice_type)

    return operands
  end

  def calculate_solution(operands)
    return case @practice_type
    when :/
      # How do I want to handle remainders?
      operands[0] / operands[1] if @practice_type == :/
    when :!
      10**@operand_length - operands[0] if @practice_type == :!
    else
      operands.reduce(@practice_type) 
    end
  end

  def generate_problem
    operands = generate_operands
    solution = calculate_solution(operands)
    text = @practice_type == :! ? "\n#{@practice_type.to_s} #{operands[0].to_s} = " : "\n#{operands[0].to_s} #{@practice_type.to_s} #{operands[1].to_s} = "

    return {:operands => operands, :solution => solution, :text => text}
  end

  def ask_problem(problem)
    response = nil
    until response.to_i == problem[:solution]
      print problem[:text]
      response = gets.chomp
      if response.to_i != problem[:solution] 
        puts "Incorrect, try again."
        @incorrect_responses += 1
      end
    end

    puts "Correct!"
  end
end
