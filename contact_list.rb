#!/usr/bin/ruby
require 'pry'
require 'active_record'
require '/vagrant/Ruby/W3D3/contact_list/lib/contact'
require '/vagrant/Ruby/W3D3/contact_list/lib/phone_number'
require '/vagrant/Ruby/W3D3/contact_list/contact_database'
require '/vagrant/Ruby/W3D3/contact_list/application_help'
require '/vagrant/Ruby/W3D3/contact_list/application_new'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets
class Application


  def connection
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      database: 'contact_list',
      username: 'development',
      password: 'development',
      host: 'localhost',
      port: 5432,
      pool: 5,
      encoding: 'unicode',
      min_messages: 'error'
    )
  end

  def get_input(message)
    puts message
    return STDIN.gets.chomp
  end

  def run
    connection
    loop do
      puts "Enter a command:"
      command, arg = gets.chomp.split(' ')
      case command
      when 'help'
        puts ApplicationHelp.new.run
      when 'new'
        puts ApplicationNew.new.run
      when 'list'
        Contact.find_each do |contact|
          phone_numbers = ''
          contact.phone_numbers.each do |number|
            phone_numbers << number.to_s
          end
          puts "#{contact} #{phone_numbers}"
        end
      when 'update'
        result = Contact.find(arg)

        puts "Enter first name:"
        result.firstname = gets.chomp
        puts "Enter last name:"
        result.lastname = gets.chomp
        puts "Enter email:"
        result.email = gets.chomp
        
        result.save
      when 'show'
        puts Contact.find(arg)
      when 'find'
        puts Contact.where("firstname LIKE '%'||?||'%' OR lastname LIKE '%'||?||'%' OR email LIKE '%'||?||'%'", arg, arg, arg)
      when 'delete'
        user = Contact.find(arg)
        user.destroy
      when 'quit'
        exit
      end
    end
  end
  
end

my_app = Application.new
my_app.run




