#!/usr/bin/ruby
require 'pry'
require '/vagrant/Ruby/W2D1/contact_list/contact'
require '/vagrant/Ruby/W2D1/contact_list/contact_database'
require '/vagrant/Ruby/W2D1/contact_list/application_help'
require '/vagrant/Ruby/W2D1/contact_list/application_new'

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
      puts ApplicationHelp.new.run
    when 'new'
      puts ApplicationNew.new.run
    when 'list'
      puts "ID\tName(Email)"
      puts Contact.all
      puts '---'
      puts "#{@@contact_list_array.length} records total"
    when 'show'
      puts Contact.show(ARGV[1])
    when 'find'
      puts Contact.find(ARGV[1])
    end
  end
  
end

my_app = Application.new
my_app.run
