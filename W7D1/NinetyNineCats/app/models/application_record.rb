require "securerandom"
require "bcrypt"

class ApplicationRecord < ActiveRecord::Base
    include SecureRandom
    include BCrypt
    self.abstract_class = true
end
