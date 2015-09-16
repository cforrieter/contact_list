class Contact < ActiveRecord::Base
  has_many :phone_numbers

  def to_s
    # return string representation of Contact
    "#{self.id}:\t#{self.firstname} #{self.lastname}(#{self.email})"
  end
end
