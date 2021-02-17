class User < ApplicationRecord
    has_many :enrollments
    has_many :instruments, through: :enrollments

    has_secure_password
end
