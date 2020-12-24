class User < ApplicationRecord

  
  acts_as_authentic do |c| c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt end

    validates :name, presence: true, length: {minimum: 1}
    validates :email, presence: true, uniqueness: true, length: {minimum: 5}
    validates :password, :confirmation => true, length: {minimum: 4}
    validates :password_confirmation, presence: true

    #-----------------------New Stuff ---------------------------------------


    #------------------------------------------------------------------------

    #---------------Unsure if working--------------
    #validates_presence_of :password, :on => :create
    #validates_presence_of :email
    #validates_uniqueness_of :email
    #----------------------------------------------

    def self.authenticate(email, password)
      user = find_by_email(email)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    end

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
  end