class User < ActiveRecord::Base

	# Relationship
	has_many :tokens, dependent: :destroy

	# Validations
	validates :email, presence: true, uniqueness: true
  validates :name, :lastname, presence: true
	validates :password, presence: true 
  validates :password, length: {minimum: 4}
  
  # Callbacks
  before_save :format_attributes

  # Methods
  private
  def format_attributes
    self.name.downcase!
    self.lastname.downcase!
  end
end
