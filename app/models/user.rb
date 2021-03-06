class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :articles, dependent: :destroy
    validates :username, presence:true, 
                         length:{minimum:3, maximum: 25}, 
                         uniqueness:{ case_sensitive:false }
    VALID_EMAIL_REGEX = (/\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/)
    validates :email, presence:true,
                      length:{maximum: 105}, 
                      uniqueness:{ case_sensitive:false },
                      format: {with: VALID_EMAIL_REGEX};
    has_secure_password
end