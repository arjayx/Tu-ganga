class Token < ActiveRecord::Base
	
  # Relationship
  belongs_to :user

  # General validations
  validates :key, uniqueness: true
  
  # Callbacks
  before_create :generate_authentication_key

  # Methods

  # This method to verifie if token haven't expired
  def has_expired?
    DateTime.now < self.expires_at
  end

  private

  # This method generate uniqueness token to save in database
  def generate_authentication_key
    begin
      self.key = SecureRandom.uuid.gsub(/-/, "")
    end while(Token.where(key: self.key).any?)
    self.expires_at = 1.month.from_now   
  end
end
