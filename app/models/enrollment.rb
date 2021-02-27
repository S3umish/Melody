class Enrollment < ApplicationRecord
    belongs_to :instrument
    belongs_to :user


    validates :instrument, :level, :duration, presence: true
    validates :price, numericality: {greater_than: 0, message:  "should be $39, $49, $89 only !!"}
    validates :student, presence: true, uniqueness: { message: "Name is already taken." }

    scope :order_by_date, -> { order(created_at: :desc) }
    scope :order_by_price, -> { order(price: :desc) }
    
    accepts_nested_attributes_for :instrument, :reject_if=> all_blank, :allow_destroy =>true


    # The below method is throwing error hence have defined as scope method. 
    # Its somehow conflicting with order_by_date and gives issues 
    # with nested attributes hence have used scope method as defined above.

    # def self.order_by_price
    #     self.order(price: :desc).limit(5)
    # end
    
end