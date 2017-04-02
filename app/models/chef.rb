class Chef < ApplicationRecord
    before_save { self.email = email.downcase}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :chefname, presence: true , length: {maximum: 30}
    validates :email, presence: true, length: {maximum: 255},
                      format: { with: VALID_EMAIL_REGEX},
                      uniqueness: {case_sensitive: false}
end