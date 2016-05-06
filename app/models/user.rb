class User < ActiveRecord::Base
	# Relationship
	has_many :tokens
end
