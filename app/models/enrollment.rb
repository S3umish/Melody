class Enrollment < ApplicationRecord
    belongs_to :instrument
    belongs_to :user

    validates :level, :duration, presence: true
    validates :instrument, presence: true

    validates :price, numericality: {greater_than: 0, message: "$39, $49, $89 only !!"}
    validates :student, presence: true, uniqueness: { case_sensitive: false }

    accepts_nested_attributes_for :instrument, :reject_if=> all_blank, :allow_destroy =>true
    
    def enrollment_attributes=(enrollment_attributes)
        enrollment = Enrollment.find_or_create_by(enrollment_attributes)
        self.enrollment = enrollment.create_order_desc
        save 
    end

    def self.find_by_enrollment_id(id)
        binding.pry
        where(enrollment: id)
    end

    def self.create_order_desc
        order("created_at DESC")
    end

end
