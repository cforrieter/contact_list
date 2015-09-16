class PhoneNumber < ActiveRecord::Base
  belongs_to :contact
  
  def to_s
    # return string representation of Contact
    "#{self.label}: #{self.phone_number}"
  end
end
