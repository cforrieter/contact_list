#!/usr/bin/ruby
require '/vagrant/Ruby/W2D1/contact_list/contact'
require '/vagrant/Ruby/W2D1/contact_list/contact_database'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets
class Application
  
  def self.contact_list_array
    @@contact_list_array
  end

  def initialize
    @@contact_list_array = ContactDatabase.load
  end

  def run
    case ARGV[0]
    when 'help'
      puts "Here is a list of available commands:"
      puts "\t new - Create a new contact"
      puts "\t list - List all contacts"
      puts "\t show - Show a contact"
      puts "\t find - Find a contact"
      puts "\t help - Show this list"
    when 'new'
      puts "New user creation:"
      puts "\tWhat is their email address?"
      email = STDIN.gets.chomp

      @@contact_list_array.each do |contact|
        if contact.email == email
          puts "That email already exists! Please try again with a new email." 
          exit
        end
      end

      puts "\tWhat is their full name?"
      fullname = STDIN.gets.chomp

      adding_numbers = true
      all_phone_numbers = ' '
      while adding_numbers == true
        puts "\tWhat is their phone number? (0 for none)"
        phone_number = STDIN.gets.chomp
        if phone_number == '0'
          adding_numbers = false
        else
          puts "\tWhat is this phone number for? (Work, mobile, etc)"
          label = STDIN.gets.chomp
          all_phone_numbers << " #{label}: #{phone_number}"
        end
      end
      puts "Contact created with ID #{Contact.create(@@contact_list_array.length, fullname, email, all_phone_numbers)}"
    when 'list'
      puts "ID\tName(Email)"
      puts Contact.all
      puts '---'
      puts "#{@@contact_list_array.length} records total"
    when 'show'
      Contact.show(ARGV[1])
    when 'find'
      puts Contact.find(ARGV[1])
    end
  end
  
end

my_app = Application.new
my_app.run
