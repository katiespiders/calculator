include Math

def check_operator(operator)

  # each operation is the key for a list of inputs that map to it
  valid_operators = {
    addition: ['addition', 'add', '+'],
    subtraction: ['subtraction', 'subtract', '-'],
    multiplication: ['multiplication', 'multiply', '*', 'x'],
    division: ['division', 'divide', '/', '÷'],
    exponentiation: ['exponentiation', 'exponent', 'raise', 'power', '**', '^'],
    square_root: ['square root', 'sqrt', '√']
  }

  valid_operators.each do |operation, symbol_list|
    if symbol_list.include? operator.downcase # search each hash entry for the input
      return operation
    end
  end
  if operator.downcase == 'q' or operator.downcase == 'quit'
    abort "See you later, alligator!" # allow user to quit
  end
  return nil # this function will continue to be called if input is not valid or quit
end


def calculate(operator, a, b=0) # set b to default 0 to account for sqrt taking only one argument
  case operator
  when :addition
    puts "#{a} + #{b} = #{a+b}"
    return a+b
  when :subtraction
    puts "#{a} - #{b} = #{a-b}"
    return a-b
  when :multiplication
    puts "#{a} * #{b} = #{a*b}"
    return a*b
  when :division
    if b == 0
      abort "You can't divide by zero."
    elsif a%b == 0
      puts "#{a} ÷ #{b} = #{a/b}" # print integer result if a is a multiple of b
      return a/b
    else
      puts "#{a} ÷ #{b} = #{a.to_f/b.to_f}" # otherwise print float
      return a.to_f/b.to_f
    end
  when :exponentiation
    puts "#{a} ^ #{b} = #{a**b}"
    return a**b
  when :square_root
    puts "√#{a} = #{Math.sqrt(a)}"
    return Math.sqrt(a)
  else # This function is called after the operator check and should never be passed an invalid value
    puts operator
    abort "This error should never happen."
  end
end

def prompt_for_number
  number = process_input
  while not number
    puts "That's not a number. Try again."
    number = process_input
  end
  return number
end

def process_input
  number = gets.chomp
  is_zero = true
  has_decimal = false

  if number.downcase == 'q'
    abort "See you later, alligator!"
  end

  number.split("").each do |char|
    if char != "0" and char != "."
      is_zero = false
    end
    if char == "."
      has_decimal = true
    end
  end

  if is_zero
    if has_decimal
      return 0.0
    else
      return 0
    end
  elsif number.to_i == 0
    return nil
  elsif has_decimal
    return number.to_f
  else
    return number.to_i
  end
end

def get_operator
  operator = gets.chomp
  operator = check_operator(operator)
  while not operator
    puts "I don't understand :( Try again?"
    operator = gets.chomp
    operator = check_operator(operator)
  end
  return operator
end

def do_math(operator, continuation=false, prev_answer = 0)
  if not continuation
    if operator == :square_root
      puts "Square root of what?"
      number = prompt_for_number
      calculate(operator, number)
    else
      puts "Give me a number!"
      number1 = prompt_for_number
      puts "Give me another one!"
      number2 = prompt_for_number
      calculate(operator, number1, number2)
    end
  else
    if operator == :square_root
      calculate(operator, prev_answer)
    else
      puts "Give me another number!"
      number2 = prompt_for_number
      calculate(operator, prev_answer, number2)
    end
  end
end


def main

  puts "Let's do some MATH!!!"
  puts "I can do addition, subtraction, multiplication, division, exponentiation, and square roots. What would you like? (Enter Q to quit at any time.)"

  operator = get_operator
  answer = do_math(operator)

  puts "Would you like to do some more math on #{answer}?"
  continue = gets.chomp

  while continue.downcase == "y" or continue.downcase == "yes"
    puts "What do you want to do to #{answer}?"
    operator = get_operator
    answer = do_math(operator, true, answer)
    puts "Would you like to do some more math on #{answer}?"
    continue = gets.chomp
  end

  puts "See you later, alligator!"
end

main
