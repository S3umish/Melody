class User < ApplicationRecord
    has_many :enrollments
    has_many :instruments, through: :enrollments
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    has_secure_password
end
