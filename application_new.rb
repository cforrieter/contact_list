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

      first_name = get_input("\tWhat is their first name?")
      last_name = get_input("\tWhat is their last name?")

      adding_numbers = true
      all_phone_numbers = []
      while adding_numbers
        phone_number = get_input("\tWhat is their phone number? (0 for none)")
        if phone_number == '0'
          adding_numbers = false
        else
          label = get_input("\tWhat is this phone number for? (Work, mobile, etc)")
          all_phone_numbers << [label, phone_number]
        end
      end
      new_user = Contact.new(first_name, last_name, email, all_phone_numbers)
      new_user.save
  end
end