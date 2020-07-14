class User < ApplicationRecord
    validates :password_digest, presence: { message: 'Must enter a password' }
    validates :user_name, :session_token , uniqueness: true, presence: true

    after_initialize :ensure_session_token

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(user_name: username)
        return nil unless user && user.is_password?(password)
        user
    end
    
    attr_reader :password

end
