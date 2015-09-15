require 'pg'
require 'pry'

class Contact
 
  attr_accessor :first_name, :last_name, :email, :phone_numbers, :id

  def initialize(first_name, last_name, email, phone_numbers, id = nil)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone_numbers = phone_numbers
  end

  def save
    if self.id
      Contact.connection.exec("UPDATE contacts SET firstname = '#{first_name}', lastname = '#{last_name}', email = '#{email}' WHERE id = '#{id}';")
    else
      self.id = Contact.connection.exec("INSERT INTO contacts (firstname, lastname, email) VALUES ('#{first_name}', '#{last_name}', '#{email}') RETURNING id;")[0]['id'].to_i
      phone_numbers.each do |label, number|
        Contact.connection.exec("INSERT INTO phone_numbers (contact_id, phone_number, label) VALUES ('#{id}', '#{number}', '#{label}');")
      end
    end
  end

  def destroy
    Contact.connection.exec("DELETE FROM contacts WHERE id = '#{id}';")
  end
 
  def to_s
    # return string representation of Contact
    "#{self.id}:\t#{self.first_name} #{self.last_name}(#{self.email}) #{self.phone_numbers.join(': ')}"
  end
  
  ## Class Methods
  class << self
    def connection
      PG.connect(
        host: 'localhost',
        dbname: 'contact_list',
        user: 'development',
        password: 'development'
      )
    end
  
    def find(id)
      #A class method to SELECT a contact row from the database by id and return a Contact instance that represents ("maps to") that row.
      convert_to_contact(connection.exec("SELECT * FROM contacts where id = '#{id}'"))
        
    end

    def find_all_by_firstname(name)
      convert_all_to_contacts(connection.exec("SELECT * FROM contacts where firstname = '#{name}'"))
    end

    def find_all_by_lastname(name)
      convert_all_to_contacts(connection.exec("SELECT * FROM contacts where lastname = '#{name}'"))
    end

    def find_by_email(email)
      convert_to_contact(connection.exec("SELECT * FROM contacts where email = '#{email}'"))
    end

    def exists?(email)
      connection.exec("SELECT * FROM contacts where email = '#{email}'").cmd_tuples >= 1
    end
  
    def all
      # TODO: Return the list of contacts, as is
      convert_all_to_contacts(connection.exec("SELECT * FROM contacts ORDER BY id"))
    end

    def get_phone_numbers(id)
      phone_numbers = []
      connection.exec("SELECT * FROM phone_numbers WHERE contact_id = '#{id}'").each do |row|
        phone_numbers << [row['label'], row['phone_number']]
      end
      phone_numbers
    end

    def convert_to_contact(pg_result)
      pg_result.each do |row|
        return Contact.new(row['firstname'], row['lastname'], row['email'], [], row['id'])
      end
      nil
    end

    def convert_all_to_contacts(pg_result)
      contacts = []
      pg_result.each do |row|
        contacts << Contact.new(row['firstname'], row['lastname'], row['email'], get_phone_numbers(row['id']), row['id'])
      end
      contacts
    end
  end
 
end
