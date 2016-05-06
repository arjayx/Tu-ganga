class Token < ActiveRecord::Base
	# Relationship
  belongs_to :user

  # General validations
  
  # Callbacks
  before_create :generate_authentication_key

  # Methods
  private
  def generate_authentication_key
    begin
      self.key = SecureRandom.uuid.gsub(/-/, "")
    end while(Token.where(key: self.key).any?)    
  end
end
