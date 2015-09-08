class ApplicationNew

  def get_input(message)
    puts message
    return STDIN.gets.chomp
  end
  
  def run
    puts "New user creation:"
      
      email = get_input("\tWhat is their email address?")

      if Contact.exists?(email)
        puts "That email already exists! Please try again with a new email." 
        exit
      end

      fullname = get_input("\tWhat is their full name?")

      adding_numbers = true
      all_phone_numbers = ' '
      while adding_numbers
        phone_number = get_input("\tWhat is their phone number? (0 for none)")
        if phone_number == '0'
          adding_numbers = false
        else
          label = get_input("\tWhat is this phone number for? (Work, mobile, etc)")
          all_phone_numbers << " #{label}: #{phone_number}"
        end
      end
      return "Contact created with ID #{Contact.create(fullname, email, all_phone_numbers)}"
  end
end