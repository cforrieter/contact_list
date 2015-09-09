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

  def to_a
    [@id, @name, @email, @phone_numbers]
  end
  
  ## Class Methods
  class << self
    def create(name, email, phone_numbers)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      id = Application.contact_list_array.length
      new_contact = Contact.new(id, name, email, phone_numbers)
      Application.contact_list_array << new_contact
      ContactDatabase.save(new_contact.to_a)
      return id
    end
  
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      Application.contact_list_array.select { |contact| contact.name.match(term) || contact.email.match(term) }
    end

    def exists?(email)
      Application.contact_list_array.each do |contact|
        if contact.email == email
          return true
        end
      end
      return false
    end
  
    def all
      # TODO: Return the list of contacts, as is
      Application.contact_list_array
    end
    
    def show(id_to_search)
      # TODO: Show a contact, based on ID
      Application.contact_list_array.detect { |contact| contact.id == id_to_search }
    end
    
  end
 
end