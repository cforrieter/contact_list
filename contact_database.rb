## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase
  @@database = 'contacts.csv'
  
  def self.load
    contacts_array = []
    CSV.foreach("#{@@database}") do |row|
      contacts_array << Contact.new(row[0], row[1], row[2], row[3])
    end
    return contacts_array
  end

  def self.save(array)
    CSV.open("#{@@database}", "a") do |csv|
      csv << array
    end
  end

end