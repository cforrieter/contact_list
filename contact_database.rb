## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase
  @@database = 'contacts.csv'
  
  def self.load
    CSV.read("#{@@database}").map { |row| Contact.new(row[0], row[1], row[2], row[3]) }
  end

  def self.save(array)
    CSV.open("#{@@database}", "a") do |csv|
      csv << array
    end
  end

end

# def connection
#   PG.connect(
#     host: 'localhost',
#     dbname: 'contact_list',
#     user: 'development',
#     password: 'development'
#   )
# end