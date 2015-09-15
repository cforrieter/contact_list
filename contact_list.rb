#!/usr/bin/ruby
require 'pry'
require '/vagrant/Ruby/W3D2/contact_list/contact'
require '/vagrant/Ruby/W3D2/contact_list/contact_database'
require '/vagrant/Ruby/W3D2/contact_list/application_help'
require '/vagrant/Ruby/W3D2/contact_list/application_new'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets
class Application

  def get_input(message)
    puts message
    return STDIN.gets.chomp
  end

  def run
    loop do
      puts "Enter a command:"
      command, arg = gets.chomp.split(' ')
      case command
      when 'help'
        puts ApplicationHelp.new.run
      when 'new'
        puts ApplicationNew.new.run
      when 'list'
        puts Contact.all
      when 'update'
        result = Contact.find(arg)

        puts "Enter first name:"
        result.first_name = gets.chomp
        puts "Enter last name:"
        result.last_name = gets.chomp
        puts "Enter email:"
        result.email = gets.chomp
        
        result.save
      when 'show'
        puts Contact.find(arg)
      when 'find'
        puts Contact.find(arg)
      when 'quit'
        exit
      end
    end
  end
  
end

my_app = Application.new
my_app.run
