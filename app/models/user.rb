class User < ActiveRecord::Base
    attr_accessible :name, :email, :password, :password_confirmation
    has_secure_password
    
    valid_email_format_regex = /\A[\w+\-\.]+@[a-z\d\-\.]+\.[a-z]+\z/i
    
    validates :name,        presence: true,
                            length: { maximum: 50 }
                        
    
    validates :email,       presence: true,
                            format: { with: valid_email_format_regex },
                            uniqueness: { case_sensitive: false }
                        
    validates :password,    length: { minimum: 6 }
    
end
