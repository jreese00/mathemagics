def print_menu(menu, header="")
    puts header unless header.empty?
    menu.each { |key,val| puts "#{key.to_s}) #{val.to_s}" }
    print "> "
end

def get_integer_input(prompt="Enter a number > ", min=0, max=1000)
  response = nil
  until response.is_a?(Integer) && (min..max).cover?(response)
    print "\n" + prompt
    begin
      response = Integer(gets.chomp)
    rescue
      response = nil
    end
    puts "Invalid number. Please enter a number between #{min} and #{max}" if response.nil? || !(min..max).cover?(response)
  end
  return response
end
