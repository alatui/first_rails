class User < ActiveRecord::Base

  has_many :articles, dependent: :destroy

  #before_save {self.email = email.downcase }
  before_save { self.email = to_down(email) }

  validates :username, presence: true,
            uniqueness: { case_sensitive: false},
            length: {minimum: 3, maximum: 25}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true,
            length: {maximum: 105},
            uniqueness: { case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  private
    def to_down(word)
      word.downcase
    end


end