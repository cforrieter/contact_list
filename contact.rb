class Contact
 
  attr_accessor :name, :email, :id, :phone_numbers

  def initialize(id, name, email, phone_numbers)
    # TODO: assign local variables to instance variables
    @id = id
    @name = name
    @email = email
    @phone_numbers = phone_numbers
  end
 
  def to_s
    # TODO: return string representation of Contact
    "#{self.id}:\t#{self.name}(#{self.email})#{self.phone_numbers}"
  end
 
  ## Class Methods
  class << self
    def create(id, name, email, phone_numbers)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      new_contact = Contact.new(id, name, email, phone_numbers)
      Application.contact_list_array << new_contact

      ContactDatabase.save([id, new_contact.name, new_contact.email, new_contact.phone_numbers])
      return id
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      search_results = []
      Application.contact_list_array.each do |contact|
        if contact.name.match(term) || contact.email.match(term)
          search_results << contact
        end
      end
      return search_results
    end
 
    def all
      # TODO: Return the list of contacts, as is
      Application.contact_list_array
    end
    
    def show(id_to_search)
      # TODO: Show a contact, based on ID
      Application.contact_list_array.each do |contact|
        puts contact if contact.id == id_to_search
      end
    end
    
  end
 
end